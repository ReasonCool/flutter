 //firbase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart'; 
import 'package:firebase_auth/firebase_auth.dart';  //登入



Future <Map<String,dynamic>>  firebaseInit ()  async{

bool isLogin = false;
String? providerId; 


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final remoteConfig = FirebaseRemoteConfig.instance;
  print("firebase a");
  await remoteConfig.fetchAndActivate();
 print("firebase b");
  remoteConfig.onConfigUpdated.listen((event) async {
  await remoteConfig.activate(); 
   
  // Use the new config values here.
  //通知狀態更新


  });
    
  //確認是否已登入
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    // var loginInfo =  LoginModel();
    // loginInfo.setProviderId("google");
    if (user != null) {
        for (final providerProfile in user.providerData) {
        print("login user info : $providerProfile");
        // ID of the provider (google.com, apple.com, etc.)
        final provider = providerProfile.providerId;
        providerId = provider;
        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
        isLogin = true;

    }
     
    }else{
      //未登入
      print('none login');
      
    }

    

  });

 
  return {
      'isLogin': isLogin,
      'providerId': providerId,
    };
}

