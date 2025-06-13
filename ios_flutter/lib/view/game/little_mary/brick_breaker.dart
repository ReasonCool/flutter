import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components.dart';
import 'config.dart';

import 'color_text_sprite.dart';
import 'betting_tap.dart';
 import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
class BrickBreaker extends FlameGame {
  BrickBreaker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );
late final ColoredTextSprite creditCoinTextSprite;
  double get width => size.x;
  double get height => size.y;

   int bounsWinCoin = 0;
   int creditCoin = 100;
  
   bool  editBetting(int betCoint,String betStr){
    print('editBetting betStr: $betStr, betCoint:$betCoint  creditCoin: $creditCoin');
    if(creditCoin == 0) return false;
    creditCoin -= 1;
     creditCoinTextSprite.editTextValue(creditCoin.toString());
    return true;


   }
  var ligthData = Map<int,RectangleComponent>();
  
  
  
  
  
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();



  camera.viewfinder.anchor = Anchor.topLeft;

  world.add(PlayArea());

 Vector2 startPosition = Vector2(10,10); 


final coinTitleSprite = createBettingTextSprite(BettingInfo, startPosition,Vector2(120, 50));
 final  coinTitleSpriteComponents =   coinTitleSprite.$1;
startPosition =  coinTitleSprite.$2;
coinTitleSpriteComponents.forEach((item)=> world.add(item)); 


final coinSprite = createBettingTextSprite(['0','0'], startPosition,Vector2(120, 50));
 final  coinSpriteComponents =   coinSprite.$1;
startPosition =  coinSprite.$2;
coinSpriteComponents.forEach((item)=> world.add(item)); 

coinSpriteComponents[0].editTextValue(bounsWinCoin.toString());
creditCoinTextSprite = coinSpriteComponents[1];
creditCoinTextSprite.editTextValue(creditCoin.toString());

//加上燈號及小圖示  
//小圖示  
final spriteInfos = await createSpriteInfos(tablePath,tableNames );
final playTableInfos =   createPlayTablePosition(spriteInfos,startPosition);
final playTableSpriteComponents =   playTableInfos.$1;
startPosition =  playTableInfos.$2;
playTableSpriteComponents.forEach((item)=> world.add(item)); 

//燈號

int indexValue = 0;
for (SpriteComponent item in playTableSpriteComponents) {
 
  print('item.position item$item');
  final itemId = tableItemKey[indexValue];
  indexValue ++; 
  print('item.position itemId $itemId ');
  //SpriteComponent
  Vector2 pos = item.position;
  print('item.position $pos');

  final rectang = RectangleComponent(
      size: Vector2(20, 20),
      paint: BasicPalette.transparent.paint()..color = lightColor_background ,
      position: pos,
    );
  ligthData[itemId] = rectang;
  

};

print('lightData ${ligthData.length}');
ligthData.values.forEach((item){
  print('lightData12 ${item.position}');
  world.add(item);
});











final bettingColorData = createBettingTextSprite(bettingTexts, startPosition,Vector2(120, 50));
 final  bettingColorComponents =   bettingColorData.$1;
startPosition =  bettingColorData.$2;
bettingColorComponents.forEach((item)=> world.add(item)); 

final bettingSpriteInfos = await createSpriteInfos(bettingItemPath, bettingItemNames);
final bettingInfos =   createBettingPosition(bettingSpriteInfos,startPosition);
final bettingSpriteComponents =   bettingInfos.$1;
print('bett1 $startPosition');
 startPosition =  bettingInfos.$2;

bettingSpriteComponents.forEach((item)=> world.add(item)); 
print('bett2 $startPosition');
//startPosition.y  += 120;
final bettingData = createBettingTapEditSprite(bettingItemNames, startPosition,editBetting);
final  bettingComponents =   bettingData.$1;
startPosition =  bettingData.$2;
bettingComponents.forEach((item)=> world.add(item)); 


//controller ui

 

}



(List<ColoredTapTextSprite>,Vector2) createBettingTapEditSprite(List<String> bettingStrInfos,Vector2 startPosition,
bool Function(int newValue,String itemName) onTapCounterChanged){

   

double x1 = startPosition.x;
   double y1 = startPosition.y;
    Vector2 endPosition = Vector2(x1, y1);
    double maxWidth = gameWidth-startPosition.x-startPosition.x;
   int maxColumn = bettingStrInfos.length;
   double widthValue = 120;
   double scaleValue = (maxWidth/maxColumn)/widthValue; 

  final coloredSprite =  bettingStrInfos.map((bettingTxt){ 

  String bettingItemId = bettingTxt;

  final sprite = ColoredTapTextSprite(itemId:bettingItemId, backgroundColor: Color.fromARGB(255, 148, 132, 171), 
    colorSize: Vector2(widthValue*scaleValue ,widthValue*scaleValue),position: Vector2(x1, y1),
    onCounterChanged: (newValue,itemId) {

        print('$itemId 計數器值變更為: $newValue');
        return onTapCounterChanged(newValue,itemId);
      },
    );
  
     
    
    x1 += widthValue * scaleValue;
    return sprite;
  }).toList();

    endPosition.x = startPosition.x;
    endPosition.y +=  widthValue * scaleValue;;
    return (coloredSprite,endPosition);
}

 
(List<ColoredTextSprite>,Vector2) createBettingTextSprite(List<String> bettingStrInfos,Vector2 startPosition,Vector2 colorSize){
 
double x1 = startPosition.x;
   double y1 = startPosition.y;
    Vector2 endPosition = Vector2(x1, y1);
    double maxWidth = gameWidth-startPosition.x-startPosition.x;
   int maxColumn = bettingStrInfos.length;
   double widthValue = colorSize.x;
   double scaleValue = (maxWidth/maxColumn)/widthValue; 
   

  final coloredSprite =  bettingStrInfos.map((bettingTxt){ 
     
    final sprite =  ColoredTextSprite(backgroundColor: const  Color(0xFF3366CC), 
     text: bettingTxt,position: Vector2(x1, y1),colorSize:Vector2(colorSize.x * scaleValue, colorSize.y));
    x1 += colorSize.x * scaleValue ;
    return sprite;
  }).toList();

    endPosition.x = startPosition.x;
    endPosition.y +=  colorSize.y;
    return (coloredSprite,endPosition);
}


(List<SpriteComponent>,Vector2) createBettingPosition(List<Sprite> spriteInfos ,Vector2 startPosition){

   double x1 = startPosition.x;
   double y1 = startPosition.y;
    Vector2 endPosition = Vector2(x1, y1);
    double maxWidth = gameWidth-startPosition.x-startPosition.x;
   int maxColumn = 8;
   double widthValue = 120;
   double scaleValue = (maxWidth/maxColumn)/widthValue; 
  
   int index = 0;
   
    
   
   final spriteComponents = spriteInfos.map((spriteInfo){  
     index ++; 
      if(index > 1){
           x1 +=  widthValue*scaleValue;
        }
     
     
      final spriteComponent =   SpriteComponent(sprite:spriteInfo ,position: Vector2(x1, y1),scale: Vector2(scaleValue,scaleValue));
    
      return spriteComponent;
    }).toList(); 
    endPosition.x = startPosition.x;
    endPosition.y +=  widthValue*scaleValue;
    return (spriteComponents,endPosition);
  }


(List<SpriteComponent>, Vector2) createPlayTablePosition(List<Sprite> spriteInfos ,Vector2 startPosition){

   double x1 = startPosition.x;
   double y1 = startPosition.y;
    double widthValue = 120;
   int row = 1;
   double maxWidth = gameWidth-startPosition.x-startPosition.x;
   bool isLeft = true;
   int index = 0;
   int maxColumn = 7;
    double scaleValue = ((maxWidth)/maxColumn)/widthValue; 
   Vector2 endPosition = Vector2(x1, y1);
   
   final spriteComponents =  spriteInfos.map((spriteInfo){  
     
      index ++;
       if(index <= maxColumn   ){
        row = 1;
        if(index > 1){
           x1 +=   widthValue*scaleValue;
        }
       
        y1 = startPosition.y;
       }else if(index <= (spriteInfos.length - maxColumn )){
        if(isLeft == true){
          row++;
          isLeft = false;
          x1 = startPosition.x;
          y1 +=  widthValue*scaleValue;
        }else{
          isLeft = true;
          x1 += ((widthValue*scaleValue * 6) as num).toDouble()  ;
        }
        
       }else{
        //last row 
        if(index ==  (spriteInfos.length - maxColumn ) + 1){
          row++;
          x1 = startPosition.x;
          y1 += widthValue*scaleValue;
        
        }else{
           x1 += widthValue*scaleValue;

        }
       } 

      endPosition.x = startPosition.x;
      endPosition.y = y1 +  (widthValue*scaleValue);
      
     
      final spriteComponent =   SpriteComponent(sprite:spriteInfo ,position: Vector2(x1, y1),scale: Vector2(scaleValue,scaleValue));

      return spriteComponent;
    }).toList(); 

    return (spriteComponents,endPosition);
  }


Future< List<Sprite>> createSpriteInfos(String tablePath,List<String> tableNames) async{

    
   
    List<String> tablePaths = tableNames.map((name) => '$tablePath$name.png').toList();

  final imageInfos = await images.loadAll(tablePaths);

  return imageInfos.map((imageInfo){  
    return Sprite(imageInfo,srcPosition:Vector2(0,0),srcSize: Vector2(  120 ,  120));
  }).toList();
  }
 
  
}