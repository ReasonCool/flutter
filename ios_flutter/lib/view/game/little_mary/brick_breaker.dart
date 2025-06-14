import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components.dart';
import 'config.dart';

import 'color_text_sprite.dart';
import 'betting_tap.dart';
 import 'package:flame/palette.dart';
import 'button_tap.dart';
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
  int startIndex =1;
  int lastIndex = 1;
   int bounsWinCoin = 0;
   int creditCoin = 100;
   late final  bettingInfo = Map<String ,int >();
   bool  editBetting(int betCoint,String betStr){
    print('editBetting betStr: $betStr, betCoint:$betCoint  creditCoin: $creditCoin');
    if(creditCoin == 0) return false;
    creditCoin -= 1;
     creditCoinTextSprite.editTextValue(creditCoin.toString());
     bettingInfo[betStr] = betCoint;
    return true;


   }

  var ligthData = Map<int,RectangleComponent>();
  //const controllValues = [
 // 'Exit','Win <->Credit','Left Side','Right Side','Start',
//];

void exchangeOnPressed(){
  print('exchangeOnPressed');
}
void winOnPressed(){
  print('winOnPressed');
}
void creditOnPressed(){
  print('creditOnPressed');
}
void leftSideOnPressed(){
  print('leftSideOnPressed');
}
void rightSideOnPressed(){
  print('rightSideOnPressed');
}
void startOnPressed(){
  print('startOnPressed');
  final   random = Random();
  lastIndex = random.nextInt(24);
  print('startOnPressed lastIndex : $lastIndex ');
   
  //執行動畫
  lightRun(startIndex,lastIndex);
  startIndex = lastIndex;

}
  
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
      size: Vector2(120, 120),
      paint: BasicPalette.transparent.paint()..color = lightColor_transparent ,
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

//  添加一个自定义的HUD按钮，位置在屏幕右上角  'Exit','Win', 'Credit','Left Side','Right Side','Start',

   startPosition.y += 20;
  world.add(createControllButton(controllValues[0],controllValues[0], startPosition, Vector2(120, 120), exchangeOnPressed));
  startPosition.x +=  130;
  world.add(createControllButton(controllValues[1],controllValues[0], startPosition, Vector2(120, 120), winOnPressed));
  startPosition.x +=  130;
  world.add(createControllButton(controllValues[2],controllValues[0], startPosition, Vector2(120, 120), creditOnPressed));
  startPosition.x +=  130;
  world.add(createControllButton(controllValues[3],controllValues[0], startPosition, Vector2(120, 120), leftSideOnPressed));
  startPosition.x +=  130;
  world.add(createControllButton(controllValues[4],controllValues[0], startPosition, Vector2(120, 120), rightSideOnPressed));
  startPosition.x +=  130;
  world.add(createControllButton(controllValues[5],controllValues[0], startPosition, Vector2(120, 120), startOnPressed));



    

}


Future<void> lightRun(int startItemKey, int endItemKey) async {
  
    final firstSpeed = 80;
    final secondSpeed = 140;
    
    final lastSpeed = 200;
    final cancelSpeed = 50;
    int j = 0;
        
    //run 2 
    for (int i = startItemKey ; i<= 24 ;i++){
      ligthData[i]?.paint.color = lightColor_selected;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: firstSpeed));
       if(i > 1){
          ligthData[i-1]?.paint.color = lightColor_selected2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    } 
     ligthData[24]?.paint.color = lightColor_transparent;
    for (int i = 1 ; i<= 24 ;i++){
      ligthData[i]?.paint.color = lightColor_selected;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: secondSpeed));
       if(i > 1){
          ligthData[i-1]?.paint.color = lightColor_selected2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    }
     ligthData[24]?.paint.color = lightColor_transparent;
     
    for (int i = 1 ; i<= endItemKey ;i++){
      ligthData[i]?.paint.color = lightColor_selected;
      // 间隔时间
       await Future.delayed(Duration(milliseconds: lastSpeed));
       if(i > 1){
          ligthData[i-1]?.paint.color = lightColor_selected2;
          await Future.delayed(Duration(milliseconds: cancelSpeed));
          ligthData[i-1]?.paint.color = lightColor_transparent; 
       }
       
       
    }
  }
  

HudCustomButton createControllButton(String title,String buttonId,Vector2 buttonPosition,Vector2 buttonSize,
void Function() onButtonPressed){
   final button = HudCustomButton(
      onPressed: () {
          onButtonPressed();
      } ,
      titleStr: title,
      size: buttonSize,
      position: buttonPosition, // 屏幕右上角，留出20像素的上边距
    );

  return button;
  

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