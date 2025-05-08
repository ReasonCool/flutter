import 'package:flutter/material.dart';
class TextFieldPage extends StatelessWidget{
  const TextFieldPage ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("TextField"),),
      body: Center(child:Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)
            ),
            obscureText: true,
          ),
        ],
      ),),
    );
  }
}