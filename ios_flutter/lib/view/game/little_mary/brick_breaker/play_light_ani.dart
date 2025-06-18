 
 import '../config.dart';
 import '../contain/color_text_sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';



showLeftRight_LeftSide(Map<int,RectangleComponent> ligthAniData ,bool isLeft)async {
   //左右閃三次
    

    var lightType  =  lightColor_transparent; 

  int playTime = isLeft? 5: 6;
  

  for (int i = 1 ; i<=  playTime ;i++){
   
    if(i %2 ==1){
        lightType  =  lightColor_ani1;
    }else{
       lightType  =   lightColor_transparent; 
    }
    
      for (int j in LeftRight_LeftItems  ){
        ligthAniData[j]?.paint.color =lightType;
        
      }
     // leftSideBtn.ChangeBGColor(lightType);

    if (i % 2 == 1) {
       lightType  = lightColor_transparent; 
    }else{
       lightType  =  lightColor_ani1;
    }
      for (int j in LeftRight_RightItems){
        ligthAniData[j]?.paint.color = lightType; 
        
      }
     //  rightSideBtn.ChangeBGColor(lightType);
      await Future.delayed(Duration(milliseconds: LeftRight_Speed)); 
       
    }  
 
}

 
 onceMore(Map<int,RectangleComponent> ligthAniData) async{
  // startIndex = lastIndex;
  //two noce more light is light 
    //run 2 
    List<ItemInfo> onceMores =  [];
     tableItemInfo.map((item){
          if(item.itemName == 'onceMore' ){
            onceMores.add(item);
         };
       });

    if (onceMores.length == 2 ){
        ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_ani1;
         ligthAniData[onceMores[1].randomValue]?.paint.color = lightColor_ani1;
          await Future.delayed(Duration(milliseconds: 300));
        ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_transparent; 
         ligthAniData[onceMores[1].randomValue]?.paint.color =lightColor_transparent; 
         await Future.delayed(Duration(milliseconds: 300));
         ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_ani1;
         ligthAniData[onceMores[1].randomValue]?.paint.color = lightColor_ani1;
          await Future.delayed(Duration(milliseconds: 300));
           ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_ani1;
         ligthAniData[onceMores[1].randomValue]?.paint.color = lightColor_ani1;
          await Future.delayed(Duration(milliseconds: 300));
        ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_transparent; 
         ligthAniData[onceMores[1].randomValue]?.paint.color =lightColor_transparent; 
         await Future.delayed(Duration(milliseconds: 300));
         ligthAniData[onceMores[0].randomValue]?.paint.color = lightColor_ani1;
         ligthAniData[onceMores[1].randomValue]?.paint.color = lightColor_ani1;
          await Future.delayed(Duration(milliseconds: 300));


    }
     
   //start button can tap
    //gameState = GameState.waitStartGame;

       
} 
  


Future<void> lightAniRun(Map<int,RectangleComponent> ligthData ,Map<int,RectangleComponent> ligthAniData,int startItemKey, int endItemKey ,[void Function ()? nextStep]) async {
   
  await  lightAniRun_Basic(ligthData,ligthAniData,startItemKey,endItemKey);

     if(nextStep != null){
      print('next Step');
      nextStep();
     }
  }

Future<void> lightAniRun_Basic(Map<int,RectangleComponent> ligthData ,Map<int,RectangleComponent> ligthAniData,int startItemKey, int endItemKey ) async {
  //var ligthAniData = Map<int,RectangleComponent>();
 // var ligthData = Map<int,RectangleComponent>();
    final firstSpeed = 80;
    final secondSpeed = 100;
    
    final lastSpeed = 140;
    final cancelSpeed = 50;
    int j = 0;
        
    //run 2 
    for (int i = startItemKey ; i<= 24 ;i++){
      ligthAniData[i]?.paint.color = lightColor_ani1;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: firstSpeed));
       if(i > 1){
          ligthAniData[i-1]?.paint.color = lightColor_ani2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthAniData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    } 
     ligthAniData[24]?.paint.color = lightColor_transparent;
    for (int i = 1 ; i<= 24 ;i++){
      ligthAniData[i]?.paint.color = lightColor_ani1;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: secondSpeed));
       if(i > 1){
          ligthAniData[i-1]?.paint.color = lightColor_ani2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthAniData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    }
     ligthAniData[24]?.paint.color = lightColor_transparent;
     
    for (int i = 1 ; i<= endItemKey ;i++){
      ligthAniData[i]?.paint.color = lightColor_ani1;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: lastSpeed));
       if(i > 1){
          ligthAniData[i-1]?.paint.color = lightColor_ani2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthAniData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    }
    
    ligthData[endItemKey]?.paint.color = lightColor_selected;
    await Future.delayed(Duration(milliseconds: cancelSpeed));
    ligthAniData[endItemKey]?.paint.color = lightColor_transparent;
    print('finish lightAniRun');
    //startIndex = lastIndex;
    //執行下個動作 

  }

