 
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'brick_breaker.dart';    
import 'custom_banner_ad.dart';
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

     // 延遲添加廣告以確保遊戲正確初始化
    Future.delayed(const Duration(milliseconds: 500), () {
      _addBannerToGame();
    });
  }         

 void _addBannerToGame() {
    // 創建廣告組件
    final banner = Positioned(
      top:125,
      left: 60,
      child: Container(
        alignment: Alignment.center,
        child: const CustomBannerAd(
          width: 270,
          height: 220,
        ),
      ),
    );
    
    // 將廣告組件傳遞給遊戲類並顯示
    game.showBanner(banner);
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
       GameWidget(game: game,
       
       // 註冊覆蓋層構建器
        overlayBuilderMap: {
          'banner': (BuildContext context, BrickBreaker game) {
            return game.bannerOverlay ?? Container();
          },}
       
       
       
       ) 
       
       , )

        



      );
         
} 
}