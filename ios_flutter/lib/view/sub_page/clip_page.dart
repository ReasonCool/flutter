import 'package:flutter/material.dart';

class ClipPage extends StatelessWidget {
  
  const ClipPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // 头像  
    Widget avatar = Container(width: 70,height: 70,color: Colors.blue,child: Padding(padding: EdgeInsets.all(10),child:Image( image: AssetImage("resource/images/cat.png"), 
             
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                ) ,
              )
           );  
                 
    return Scaffold(
      appBar: AppBar(title: Text("clip 剪裁"),),
      body: Center(
      child: Column(
        children: <Widget>[
          avatar, //不剪裁
           Padding(padding: EdgeInsets.only(top: 30),),
          ClipOval(child: avatar), //剪裁为圆形
           Padding(padding: EdgeInsets.only(top: 30),),
          ClipRRect( //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ), 
          Padding(padding: EdgeInsets.only(top: 30),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green),)
            ],
          ),
           Padding(padding: EdgeInsets.only(top: 30),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: .3,
                  widthFactor: .3,//宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界",style: TextStyle(color: Colors.green))
            ],
          ),
        ],
      ),
      )
    );
  }
}
