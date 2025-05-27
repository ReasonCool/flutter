import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/interface/email_typedef_funtion.dart';



enum EmailLoginState {
  waitLogin('等待登入'),
  success('登入成功！'),
  fail('登入失敗！'),
  aleardy('已經註登入過了！'),
 weakPassword('密碼強度不足'),
 waitEmailVerify('Email尚未驗證！請收信並驗證'),
 userNotFund('無此帳號');
    final String path;
  const EmailLoginState(this.path);


  Widget buildWidgetByEmailLoginState(List<TextFieldData>  listInfo) {

 String email = listInfo[0].controller.text;
 String pw = listInfo[1].controller.text;

  switch (this) {
    case EmailLoginState.waitLogin:
      return  waitLoginWidget();
    case EmailLoginState.aleardy:
      return  waitAlearyWidget(email);
    
    case EmailLoginState.waitEmailVerify:
      return  waitEmailVerifyWidget();
    case EmailLoginState.success:



      return  successWidget();
    
    default:
      return failWidget(); // 默认返回fail Widget
  }
}
   

   Widget waitLoginWidget(){
    return Center(child: Column(children: [
      Text(path),
    ],),);
  }

  Widget successWidget(){
    return Center(child: Column(children: [
      Text(path),
    ],),);
  }

Widget waitAlearyWidget(String email){
    return Center(child: Column(children: [
      Text(path),
    ],),);
  }

Widget waitEmailVerifyWidget(){
return Center(child: Column(children: [
      Text(path),
    ],),);
}
    

 

Widget failWidget(){
    return Center(child: Column(children: [
      Text(EmailLoginState.fail.path),
    ],),);
  }


 }

 
 
