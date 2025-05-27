 //firbase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart'; 
import 'package:firebase_auth/firebase_auth.dart';  //登入
 
 
import 'package:ios_flutter/interface/typedef_funtion.dart';
 
 
import 'package:ios_flutter/enum/email_login_enum.dart';


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

 
Future  sendEmailLoginInfo(BuildContext context,  String emailAddress,String password,VoidEmailLoginStateCallback resultCallback) async{
  
  EmailLoginState registValue = EmailLoginState.fail;
  try {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password
    );
    if(userCredential.user?.emailVerified == false){
     
      registValue = EmailLoginState.waitEmailVerify;
    }else{
      registValue = EmailLoginState.success;
    }
    
     
     print('FirebaseAuth userCredential: $userCredential');
      print('FirebaseAuth user: ${userCredential.user?.email}');


  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
       registValue = EmailLoginState.userNotFund;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
       registValue = EmailLoginState.weakPassword;
    }
  }finally{
     // 關閉等待畫面
    if (Navigator.canPop(context)) {
      Navigator.pop(context);

       
        resultCallback(registValue);
       
      

       

    }
    
  } 

}

