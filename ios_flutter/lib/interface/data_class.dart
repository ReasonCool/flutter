import 'package:flutter/material.dart';

class TextFieldData{
  String text ;
  String labelText;
  String hintText;
  Widget prefixIcon;
  String errorText;
  TextInputType keyboardType;
  TextEditingController controller  = TextEditingController();
  bool obscureText ;
  bool verifyPass;
  FocusNode focusNode = FocusNode();
  String regexpSource;
  TextFieldData({required this.text,required this.labelText,required this.hintText,
  required this.prefixIcon,this.verifyPass = true ,this.regexpSource = '', this.errorText = "",this.keyboardType = TextInputType.text,this.obscureText = false});

  static List<TextFieldData> get TestData =>  [
      TextFieldData( text: "" , labelText: '用戶名', hintText: '用戶名', prefixIcon:Icon(Icons.person)  
          ,errorText: "請輸入至少3-6個字母",regexpSource: r'^[a-zA-Z0-9]{3,6}$'),
      TextFieldData( text: "" , labelText: '電子郵件', hintText: 'xxx@xxx.xxx', 
      prefixIcon:Icon(Icons.person)   ,errorText: "不符合格式",regexpSource:r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$' ),
      TextFieldData( text: "" , labelText: '行動電話', hintText: '09xx-xxx-xxx', prefixIcon:Icon(Icons.person)
       ,errorText: "不符合格式",regexpSource: r'^09\d{2}-?\d{3}-?\d{3}$'),
      TextFieldData( text: "" , labelText: '密碼', hintText: '英數六碼', prefixIcon:Icon(Icons.person)  
      ,errorText: "不符合格式",regexpSource: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$'),

      ];
    

}
