import "package:flutter/material.dart";

class TextPage extends StatelessWidget{
  const TextPage ({Key? key}):super(key : key);

  @override
  Widget build(BuildContext context){

    String icons = "";
    // accessible: 0xe03e
    icons += "\uE03e";
    // error:  0xe237
    icons += " \uE237  1";
    // fingerprint: 0xe287
    icons += " \uE287";



    return Scaffold(
      appBar: AppBar(title: Text("text page"),),
      body: Center(child: Column(children: [ 
        Text( " 使用Material Design $icons 字体图标"),
        
        DefaultTextStyle(style: TextStyle(
          color:Colors.blue,
          backgroundColor: Colors.lightGreen,
          fontSize: 24,
        ),textAlign: TextAlign.center
        , child: 
        Column(children: [
          Text("DefaultTe❤️xtStyle"),
          Text("I am Jack",
            style: TextStyle(
              inherit: false, //2.不继承默认样式
              color: Colors.grey
            ),
          ),
        ],)
        ),
        Text("DefaultTe❤️xtStyle"),
        Text("Text 🚮Test" * 2,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            height: 3,
            fontSize: 20,
            fontFamily: "Courier",
            backgroundColor: Colors.red,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.double,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
            TextSpan(
              text: "First",
              children:   [
                TextSpan(
              text: "Second",
              style: TextStyle(
                color: Colors.red
              ),
              
            ),
            TextSpan(
              text: "third",
              style: TextStyle(
                color: Colors.red
              ),
              
            )
              ]
            ),
            TextSpan(
              text: "Second",
              style: TextStyle(
                color: Colors.red
              ),
              
            )
          ])
        )
      ],),),
    );
  }
}