import 'package:flutter/material.dart';
class EmailLoginPage extends StatelessWidget{
  const EmailLoginPage ({Key? key}): super (key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("test page"),),
      body:Center(child: Text("Test"),),
    );
  }
}