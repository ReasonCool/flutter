import 'package:flutter/material.dart';
class ScaffoldMessagePage extends StatelessWidget {
  const ScaffoldMessagePage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SnackBar')),
      body:Center(
        child: Column( 
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("這是 SnackBar!"),
                  action: SnackBarAction(label: '確定', onPressed: (){
                    print("SnackBar pass action ok");
                  }),
                  duration: Duration(seconds: 2),
              )  
              );
            }
            , child: Text("顯示 SnackBar!"))
          ]
        )
      )
    );
  }
}