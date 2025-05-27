
import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/login_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';  //登入

typedef VoidIndexCallback = void Function(int index);
typedef VoidBuildContextCallback = void Function(BuildContext context);
typedef VoidTextFieldCallback = void Function(String text, int index);
typedef VoidStringCallback = void Function(String text);

typedef VoidRegistStateCallback = void Function(RegistState registState);
 
typedef EmailRegistContextCallBack =  Function(BuildContext context,String email,String pw,VoidRegistStateCallback resultCallback);

 

