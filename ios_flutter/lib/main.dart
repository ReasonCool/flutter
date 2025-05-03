

import 'package:flutter/material.dart';
  import 'package:ios_flutter/sub_page/countPage.dart';
 import 'package:ios_flutter/sub_page/imagePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('功能展示')),
      body:Center(
        child: Column( 
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '文字功能展示 ',
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle( 
                color:Colors.green,
                  fontSize: 30,
                  height: 1.5,
                backgroundColor: Colors.yellow,
                decoration: TextDecoration.underline,
                ),
              ), 
              ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ImagePage()),
            );
          },
          child:Column( 
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          const Text('圖片展示'),
          ],),
        ),
         ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CounterPage()),
            );
          },
          child:Column( 
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          const Text('按鈕計數'),
          ],),
        ),
          ]
      )
      )
    ); 
  }
}



