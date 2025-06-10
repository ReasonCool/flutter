
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'brick_breaker.dart';    

class LittleMaryMainView extends StatefulWidget{
  
  @override
  State<LittleMaryMainView> createState() => _LittleMaryMainView();

}
class _LittleMaryMainView extends State<LittleMaryMainView>{


///ToDo : 
///判斷畫面長寬比與實際大小
///產生遊戲畫面
///   排列圖片物件
///   
late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }         

  @override
  Widget build (BuildContext context){
    final size = MediaQuery.of(context).size; 

   return Scaffold(
      appBar: AppBar(title: Text("Little Mary"),),
      body:Container(
     width: size.width,
     height: size.height,
     decoration: BoxDecoration(
       image: DecorationImage(
         image: AssetImage('resource/images/little_mary/background.png'), // Replace with your asset path
         fit: BoxFit.cover, // Cover the entire container
       ),
     ),
     child:
     //Text("sdf")
       GameWidget(game: game) 
       , )

        



      );
         
} 
}