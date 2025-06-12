import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components.dart';
import 'config.dart';

import 'color_text_sprite.dart';
import 'betting_tap.dart';
 

class BrickBreaker extends FlameGame {
  BrickBreaker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();


  camera.viewfinder.anchor = Anchor.topLeft;

  world.add(PlayArea());

 Vector2 startPosition = Vector2(10,10);
  
  final spriteInfos = await createSpriteInfos(tablePath,tableNames );
  final playTableInfos =   createPlayTablePosition(spriteInfos,startPosition);
  final playTableSpriteComponents =   playTableInfos.$1;
  startPosition =  playTableInfos.$2;


 playTableSpriteComponents.forEach((item)=> world.add(item)); 

final bettingColorData = createBettingTextSprite(bettingTexts, startPosition);
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
final bettingData = createBettingTapEditSprite(bettingValues, startPosition);
final  bettingComponents =   bettingData.$1;
startPosition =  bettingData.$2;
bettingComponents.forEach((item)=> world.add(item)); 


 


  



 

}


(List<ColoredTapTextSprite>,Vector2) createBettingTapEditSprite(List<String> bettingStrInfos,Vector2 startPosition){

double x1 = startPosition.x;
   double y1 = startPosition.y;
    Vector2 endPosition = Vector2(x1, y1);
    double maxWidth = gameWidth-startPosition.x-startPosition.x;
   int maxColumn = 8;
   double widthValue = 120;
   double scaleValue = (maxWidth/maxColumn)/widthValue; 

  final coloredSprite =  bettingStrInfos.map((bettingTxt){ 


  final sprite = ColoredTapTextSprite(backgroundColor: Color.fromARGB(255, 148, 132, 171), 
    colorSize: Vector2(widthValue*scaleValue ,widthValue*scaleValue),position: Vector2(x1, y1));
  
     
    
    x1 += widthValue * scaleValue;
    return sprite;
  }).toList();

    endPosition.x = startPosition.x;
    endPosition.y +=  widthValue * scaleValue;;
    return (coloredSprite,endPosition);
}

 
(List<ColoredTextSprite>,Vector2) createBettingTextSprite(List<String> bettingStrInfos,Vector2 startPosition){

double x1 = startPosition.x;
   double y1 = startPosition.y;
    Vector2 endPosition = Vector2(x1, y1);
    double maxWidth = gameWidth-startPosition.x-startPosition.x;
   int maxColumn = 8;
   double widthValue = 120;
   double scaleValue = (maxWidth/maxColumn)/widthValue; 

  final coloredSprite =  bettingStrInfos.map((bettingTxt){ 
     
    final sprite =  ColoredTextSprite(backgroundColor: const  Color(0xFF3366CC), 
     text: bettingTxt,position: Vector2(x1, y1),colorSize:Vector2(widthValue * scaleValue, 50));
    x1 += widthValue * scaleValue;
    return sprite;
  }).toList();

    endPosition.x = startPosition.x;
    endPosition.y +=  50;
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