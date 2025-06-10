  //firbase
import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/email_typedef_funtion.dart';
import 'package:firebase_auth/firebase_auth.dart';  //登入
import 'package:ios_flutter/enum/email_regist_enum.dart';


Future  sendEmailRegistInfo(BuildContext context,  String emailAddress,String password,VoidEmailRegistStateCallback resultCallback) async{
  
  EmailRegistState registValue = EmailRegistState.fail;
  
   
  try {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    if(userCredential.user?.emailVerified == false){
       await userCredential.user?.sendEmailVerification(); 
      registValue = EmailRegistState.waitEmailVerify;
    }
    if(userCredential.user?.emailVerified == true){
      registValue = EmailRegistState.success;
    }
     
     print('FirebaseAuth userCredential: $userCredential');
      print('FirebaseAuth user: ${userCredential.user?.email}');
      /*
      lutter: FirebaseAuth userCredential: UserCredential(additionalUserInfo: 
      AdditionalUserInfo(isNewUser: true, profile: {}, providerId: password,
       username: null, authorizationCode: null),
        credential: null, user: User(displayName: null, 
        email: dsdfsfd@sdfs.sdf, isEmailVerified: false, 
        isAnonymous: false, metadata: 
        UserMetadata(creationTime: 2025-05-26 10:16:11.823Z,
        lastSignInTime: 2025-05-26 10:16:11.823Z), 
        phoneNumber: null, photoURL: null, providerData, 
        [UserInfo(displayName: null, email: dsdfsfd@sdfs.sdf, phoneNumber: null, photoURL: null, 
        providerId: password, uid: dsdfsfd@sdfs.sdf)], 
        refreshToken: AMf-vBzJXrsAopVoCd6g_Lt3FlsuPonGVDjAccUK906LqZNfibhJ7HklR6eDjZ-PHjvTo3W2HRujCUc13YRkSGP2tAK-FgmAUCbN5evX14RPeHiSBc5Xlmh-MxfKPxRFKbwYFn3ZHkqtKjRPS5u8DvMlv-4qWdfPSxb3HOB4NzbDwvmnBrGBPddUJDSnEJD5tanOmrE4TCvGNokHMXv_5CoDG447TqSuNA,
       tenantId: null, uid: WAm9XlKhfQUA0uWrUflXsY01CJD3))
      
      */
  print("Signed in with temporary account.");

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      registValue = EmailRegistState.weakPassword;
      print('The password provided is too weak.');

    } else if (e.code == 'email-already-in-use') {
      registValue = EmailRegistState.aleardy;
      print('The account already exists for that email.');

    }
  } catch (e) {
    print(e);
  }finally{
     // 關閉等待畫面
    if (Navigator.canPop(context)) {
      Navigator.pop(context);

       
        resultCallback(registValue);
       
      

       

    }
    
  } 

        // try {
        //       // 執行實際傳送邏輯
        //       await Future.delayed(Duration(seconds: 2)); // 模擬傳送過程

        //       print('資料傳送完成');
        //     } catch (e) {
        //       print('傳送錯誤: $e');
        //     } finally {
        //       // 關閉等待畫面
        //       if (Navigator.canPop(context)) {
        //         Navigator.pop(context);
        //       }
        //     } 
    }



