import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/interface/typedef_funtion.dart';


 
 

enum EmailRegistState {
  waitRegist('等待註冊'),
  success('註冊成功！'),
  fail('註冊失敗！'),
  aleardy('已經註冊過了！'),
 weakPassword('密碼強度不足'),
 waitEmailVerify('Email尚未驗證！請收信並驗證'),
 loginFail('登入失敗'),
 loginSuccess('登入成功'),
 userNotFund('無此帳號');
    final String path;
  const EmailRegistState(this.path);


  Widget buildWidgetByEmailRegistState(List<TextFieldData>  listInfo) {

 String email = listInfo[0].controller.text;
 String pw = listInfo[1].controller.text;

  switch (this) {
    case EmailRegistState.waitRegist:
      return  waitRegistWidget();
    case EmailRegistState.aleardy:
      return  waitAlearyWidget(email);
    
    case EmailRegistState.waitEmailVerify:
      return  waitEmailVerifyWidget();
    case EmailRegistState.success:
      return  successWidget();
    
    default:
      return failWidget(); // 默认返回fail Widget
  }
}
   

   Widget waitRegistWidget(){
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
      Text(EmailRegistState.fail.path),
    ],),);
  }


 }


