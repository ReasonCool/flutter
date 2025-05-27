
import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/email_regist_enum.dart';
import 'package:ios_flutter/enum/email_login_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';  //登入

typedef VoidIndexCallback = void Function(int index);
typedef VoidBuildContextCallback = void Function(BuildContext context);
typedef VoidTextFieldCallback = void Function(String text, int index);
typedef VoidStringCallback = void Function(String text);

//email login
typedef VoidEmailLoginStateCallback = void Function(EmailLoginState emailLoginState);
typedef EmailLoginContextCallBack =  Function(BuildContext context,String email,String pw,VoidEmailLoginStateCallback resultCallback);


//email regist
typedef VoidEmailRegistStateCallback = void Function(EmailRegistState emailRegistState);
typedef EmailRegistContextCallBack =  Function(BuildContext context,String email,String pw,VoidEmailRegistStateCallback resultCallback);

 

