import 'package:flame/components.dart';
 
import '../config.dart';

import '../contain/color_text_sprite.dart';

import '../contain/betting_tap.dart';

import 'package:flame/palette.dart';

import '../contain/button_tap.dart';




Map<int,RectangleComponent> createLightDataItem(List<SpriteComponent> startGameSpriteComponents ,World world){
 var itemLigth = Map<int,RectangleComponent>();
int indexValue = 0;
for (SpriteComponent item in startGameSpriteComponents) {

  print('item.position item$item');
  final itemId = tableItemKey[indexValue];
  indexValue ++; 
  print('item.position itemId $itemId ');
  //SpriteComponent
  Vector2 pos = item.position;
  print('item.position $pos');

   
   final rectang1 = RectangleComponent(
      size: Vector2(20, 20),
      paint: BasicPalette.transparent.paint()..color = lightColor_transparent ,
      position: pos,
    );
  itemLigth[itemId] = rectang1;
  
   world.add(rectang1);
};
return itemLigth;

}


Map<int,RectangleComponent> createLightAniDataItem(List<SpriteComponent> startGameSpriteComponents ,World world){
 var itemLigth = Map<int,RectangleComponent>();
int indexValue = 0;
for (SpriteComponent item in startGameSpriteComponents) {

  print('item.position item$item');
  final itemId = tableItemKey[indexValue];
  indexValue ++; 
  print('item.position itemId $itemId ');
  //SpriteComponent
  Vector2 pos = item.position;
  print('item.position $pos');

  final rectang = RectangleComponent(
      size: Vector2(120, 120),
      paint: BasicPalette.transparent.paint()..color = lightColor_transparent ,
      position: pos,
    );
  itemLigth[itemId] = rectang; 
   world.add(rectang);

};
return itemLigth;

}


HudCustomButton createControllButton(World world,String title,String buttonId,Vector2 buttonPosition,Vector2 buttonSize,
void Function() onButtonPressed){
   final button = HudCustomButton(
      onPressed: () {
          onButtonPressed();
      } ,
      titleStr: title,
      size: buttonSize,
      position: buttonPosition, // 屏幕右上角，留出20像素的上边距
    );

    world.add(button);

    return button;
  

}


List<SpriteComponent>  createTableBGSpriteComponent(List<Sprite> sprites, Vector2 pos)  {

 return sprites.map((sprite){
    final spriteComponent =   SpriteComponent(sprite:sprite ,position:pos,scale: Vector2(1,1));

    // world.add(spriteComponent);
    spriteComponent.setOpacity(0);
    return spriteComponent;
  }).toList(); 
   
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



 