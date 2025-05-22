 //firbase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart'; 
import 'package:firebase_auth/firebase_auth.dart';  //登入


Future <Map<String,dynamic>>  firebase_autoLogin ()  async{

Map<String,dynamic> resultValue = {
  'isLogin': false,
      'providerId': null,
}; 
 

 //透過 Firebase 匿名驗證
 try {
  final userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      print('FirebaseAuth userCredential: $userCredential');
      print('FirebaseAuth user: ${userCredential.user?.isAnonymous}');
       resultValue['isLogin'] = true  ;
      if(userCredential.user?.isAnonymous == true){
        resultValue['providerId'] = 'Anonymous' ;
      }
  print("Signed in with temporary account.");

} on FirebaseAuthException catch (e) {
  switch (e.code) {
    case "operation-not-allowed":
      print("Anonymous auth hasn't been enabled for this project.");
      break;
    default:
      print("Unknown error.");
  }
}

  return resultValue ;
}

