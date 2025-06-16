import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import 'components.dart';
import 'config.dart';

import 'color_text_sprite.dart';
import 'betting_tap.dart';
 import 'package:flame/palette.dart';
import 'button_tap.dart';

enum GameState{

  waitBit(10),waitStartGame(20),startGame(25),waitDoubleGame(30),startDoubleGame(40);

  const GameState(this.enumValue);

  final int enumValue;
}

class WinInfo{
   
  final int itemIndex;
  final String winItemId;
  final int bettingCoin;
  final int winCoin;
  const WinInfo(
    
     this.itemIndex,
    this.winItemId,
    this.bettingCoin,
    this.winCoin
    ); 

}

class BrickBreaker extends FlameGame {
  BrickBreaker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );
GameState gameState = GameState.waitBit;
late final ColoredTextSprite creditCoinTextSprite;
late final ColoredTextSprite winCoinTextSprite;
late final List<ColoredTapTextSprite> bettingComponents;


late final exchangeBtn ;

late final winBtn;

late final creditBtn;

late final leftSideBtn;
   
late final rightSideBtn;
   
late final  startBtn ;

  double get width => size.x;
  double get height => size.y;
  int startIndex =1;
  int lastIndex = 1;
   int bounsWinCoin = 0;
   int creditCoin = 100;
   late List<WinInfo> winInfos =[];
   late final  bettingInfo = Map<String ,int >();
   bool  editBetting(int betCoint,String betStr){
    print('editBetting betStr: $betStr, betCoint:$betCoint  creditCoin: $creditCoin');
    if((gameState != GameState.waitBit) && (gameState != GameState.waitStartGame)){
      return false;
    }
    if(creditCoin == 0) return false;

    creditCoin -= 1;
     creditCoinTextSprite.editTextValue(creditCoin.toString());
     betCoint++;
     bettingInfo[betStr] = betCoint;
     gameState = GameState.waitStartGame;
    return true;


   }
  var ligthData = Map<int,RectangleComponent>();
  var ligthAniData = Map<int,RectangleComponent>();
  //const controllValues = [
 // 'Exit','Win <->Credit','Left Side','Right Side','Start',
//];

void exchangeOnPressed() async{
   if(gameState != GameState.waitDoubleGame){
    return;
  }
  print('exchangeOnPressed');
  //win  to credit
  if(bounsWinCoin > 0){
    
    winCoinTextSprite.editTextValueAni('0');
     creditCoin += bounsWinCoin;
   await creditCoinTextSprite.editTextValueAni(creditCoin.toString());
   gameState = GameState.waitBit;

   
  }
}
void winOnPressed(){
   if(gameState != GameState.waitDoubleGame){
    return;
  }
  print('winOnPressed');
}
void creditOnPressed(){
   if(gameState != GameState.waitDoubleGame){
    return;
  }
  print('creditOnPressed');
}
void leftSideOnPressed(){
   if(gameState != GameState.waitDoubleGame){
    return;
  }
  print('leftSideOnPressed');
   startLeftRighGame(true);
  
}

void rightSideOnPressed(){
   if(gameState != GameState.waitDoubleGame){
    return;
  }
  print('rightSideOnPressed');
  startLeftRighGame(false);
}
void startOnPressed(){
  if(gameState != GameState.waitStartGame){
    return;
  }
  winInfos.clear();

  gameState = GameState.startGame;
  
  WinInfo? winInfo = createWinItem(false);
  if(winInfo == null){
    //特殊模式
     winInfo = createWinItem(true)!;
      winInfos.add(winInfo);
     lightAniRun(startIndex,winInfo.itemIndex,specialModel);


  }else if( winInfo.winItemId == LitttleMaryItemName.once_more.name){
    winInfos.add(winInfo);
    //once more
    //執行動畫
    lightAniRun(startIndex,winInfo.itemIndex,noceMore);
  }else{
    //正常模式
    //執行動畫
     winInfos.add(winInfo);
    lightAniRun(startIndex,winInfo.itemIndex,showWinCoin_First);
  }


}
noceMore() async{
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
    gameState = GameState.waitStartGame;
       
       
} 
  
showWinCoin_First()  {
  showWinCoin(null);
}

showWinCoin(bool? isDouble ) async {
 int winCoin = 0;
if(isDouble == true){
  winCoin =  bounsWinCoin * 2;

}else if(isDouble == false){
  winCoin = 0;
}else{
  //if(isDouble == null){
   //count win coint
  
  print('showWinCoin winInfos.leght ${winInfos.length}');
  winInfos.forEach((item){
     winCoin += item.winCoin;

  });
}
   //await creditCoinTextSprite.editTextValueAni(creditCoin -  bounsWinCoin );
//清空押注項目的金額
 
  
  print("showWinCoin winCoin $winCoin");
  if(winCoin > 0 ){

    bounsWinCoin = winCoin;
    await winCoinTextSprite.editTextValueAni(bounsWinCoin.toString());
    //比大小遊戲 
    //顯示動畫
    if(isDouble == null){
      await showWaitPlayLeftRightAni();
    }
    

    gameState = GameState.waitDoubleGame;  



  }else{
    bounsWinCoin = 0;
    winCoinTextSprite.editTextValue(bounsWinCoin.toString());

    gameState = GameState.waitBit;
  }
  for (var item in  bettingComponents){
     print("bettingComponents.map");
    item.editTextValue("0");
  };

 
 







}
specialModel(){
     final winInfo = createWinItem(true)!;
      winInfos.add(winInfo);
    lightAniRun(startIndex,createWinItem(true)!.itemIndex,showWinCoin_First);

} 
showLeftRight_LeftSige(bool isLeft)async {
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
showWaitPlayLeftRightAni()async{
  
    showLeftRight_LeftSige(true);
     
    var lightType  = lightColor_transparent; 
      for (int j in LeftRight_LeftItems){
        ligthAniData[j]?.paint.color =lightType;
        
      }
      for (int k in LeftRight_RightItems){
        ligthAniData[k]?.paint.color = lightType; 
        
      }
        leftSideBtn.ChangeBGColor( lightColor_ani1);
        rightSideBtn.ChangeBGColor( lightColor_ani1);
}

WinInfo? createWinItem(isSpecialModel){
  WinInfo? winInfo ;
  int rangeValue = 25;
  if(isSpecialModel == true){
    rangeValue = 24;
  }
   final   random = Random();
  var winIndex = random.nextInt(isSpecialModel?24:25);
  print('startOnPressed lastIndex : $lastIndex ');
  
  if(isSpecialModel == true){
      final onceMores =   tableItemInfo.map((item){
         return item.itemName == 'onceMore' && item.randomValue == winIndex ;
       });
       if (onceMores.length > 0){
        winIndex -= 1;
       }

  }else{
    if (winIndex == 25){
        return winInfo;
      }
  }
 
  
  
  //錄得獎項目
  //bettingInfo[betStr] = betCoint;
  //itemIndex  取得對應的項目 tableItemInfo
  final items = tableItemInfo.where((item){
   return item.randomValue == winIndex;
  });

  print('winInfo items $items');
  print('winInfo items $items');
 
  

  for (var itemInfo in items){
    //是否有押注
    int? coins  = bettingInfo[itemInfo.betId];
    coins ??= 0;
    //有押注
    winInfo = WinInfo(winIndex, itemInfo.betId, coins, coins * itemInfo.itemBettingMultiple);
  }
  
  
  return winInfo;
}



 startLeftRighGame(bool isLeft)async{
  
  final   random = Random();
  if(random.nextInt(100)%2 == 1){
    //left win
    showLeftRightGameAni(true,isLeft);
  }else{
    //right win
    showLeftRightGameAni(false,!isLeft);
  }
  
}
showLeftRightGameAni(isLeft,isWin){
  showLeftRight_LeftSige(isLeft);
  if(isWin == true){
    //獎勵翻倍
    showWinCoin(true);
  }else{
    //獎勵歸零
    showWinCoin(false);
  }



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
winCoinTextSprite = coinSpriteComponents[0];
winCoinTextSprite.editTextValue(bounsWinCoin.toString());
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
  ligthAniData[itemId] = rectang;

   final rectang1 = RectangleComponent(
      size: Vector2(20, 20),
      paint: BasicPalette.transparent.paint()..color = lightColor_transparent ,
      position: pos,
    );
  ligthData[itemId] = rectang1;
  

};

print('lightAniData ${ligthAniData.length}');
ligthAniData.values.forEach((item){
  print('lightAniData12 ${item.position}');
  world.add(item);
});
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
 bettingComponents =    bettingData.$1;
startPosition =  bettingData.$2;
bettingComponents.forEach((item)=> world.add(item)); 


//controller ui

//  添加一个自定义的HUD按钮，位置在屏幕右上角  'Exit','Win', 'Credit','Left Side','Right Side','Start',

   startPosition.y += 20;
 exchangeBtn = createControllButton(controllValues[0],controllValues[0], startPosition, Vector2(120, 120), exchangeOnPressed);
 startPosition.x +=  130;
winBtn= createControllButton(controllValues[1],controllValues[0], startPosition, Vector2(120, 120), winOnPressed);
 startPosition.x +=  130;
 creditBtn  = createControllButton(controllValues[2],controllValues[0], startPosition, Vector2(120, 120), creditOnPressed);
 startPosition.x +=  130;
leftSideBtn =  createControllButton(controllValues[3],controllValues[0], startPosition, Vector2(120, 120), leftSideOnPressed);
    startPosition.x +=  130;
 rightSideBtn =   createControllButton(controllValues[4],controllValues[0], startPosition, Vector2(120, 120), rightSideOnPressed);
    startPosition.x +=  130;
  startBtn =   createControllButton(controllValues[5],controllValues[0], startPosition, Vector2(120, 120), startOnPressed);



  
  world.add(exchangeBtn);
 
  world.add(winBtn);
   
  world.add(creditBtn);
 
  world.add(leftSideBtn);
  
  world.add(rightSideBtn);
 
  world.add(startBtn);
  
  



    

}


Future<void> lightAniRun(int startItemKey, int endItemKey ,void Function () nextStep) async {
  
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
    startIndex = lastIndex;
    //執行下個動作

     if(nextStep != null){
      print('next Step');
      nextStep();
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