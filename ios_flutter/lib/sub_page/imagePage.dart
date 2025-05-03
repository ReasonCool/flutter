//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class ImagePage extends StatelessWidget {
  const ImagePage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ImagePage')),
      body:Center(
        child: Column( 
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '本地圖片 ', 
              ), 
              Image(
                image: AssetImage("resource/images/cat.png"),
                width:200,
                height:200,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
              Text(
              '遠端圖片 ', 
              ), 
              Image(image: NetworkImage("https://cdn2.thecatapi.com/images/9bv.jpg"),
                  width:200,
                height:200,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
           
          ]
      )
      )
    ); 
  }
}
