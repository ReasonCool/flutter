import 'package:flutter/material.dart';
 
//
class FittedBoxPage extends StatelessWidget{

  const FittedBoxPage ({super.key});


Widget wContainer(BoxFit boxFit) {
  return Container(
    width: 100,
    height: 100,
    color: Colors.red,
    child: FittedBox(
      fit: boxFit,
      // 子容器超过父容器大小
      child: Container(width: 200, height: 200, color: Colors.green,child: Text('xxxx' * 100),),
    ),
  );
}

@override
Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text("FittedBox溢出空間處理"),),
        body:Center(
      child: Column(
        children: [
         Padding(padding: EdgeInsets.all(30),child:Text("""FittedBox 在布局子组件时会忽略其父组件传递的约束，可以允许子组件无限大，即FittedBox 传递给子组件的约束为（0<=width<=double.infinity, 0<= height <=double.infinity）"""),
         ),
         wContainer(BoxFit.none),
           
        Padding(padding: EdgeInsets.all(30),child:Text('FittedBox溢出空間處理' *3)),
          wContainer(BoxFit.contain),
          
        ],
      ),
      ),
    );
  }
}

