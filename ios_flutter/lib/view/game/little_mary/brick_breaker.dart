import 'dart:async';
 
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
 

import 'components.dart';
import 'config.dart';

import 'contain/color_text_sprite.dart';
import 'contain/betting_tap.dart';
 
import 'contain/button_tap.dart';

import 'contain/tableBg.dart';

import 'brick_breaker/create_ui.dart';

import 'brick_breaker/play_light_ani.dart';

import 'brick_breaker/game_state.dart';

import 'brick_breaker/model.dart';

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

  late final HudCustomButton exchangeBtn;

  late final HudCustomButton winBtn;

  late final HudCustomButton creditBtn;

  late final HudCustomButton leftSideBtn;

  late final HudCustomButton rightSideBtn;

  late final HudCustomButton startBtn;

  late BackgroundAnimationSystem bgAnimationSystem;

 
  late  LocalCreditCoin localStorage ;

  double get width => size.x;
  double get height => size.y;
  int startIndex = 1;
  int lastIndex = 1;
  int bounsWinCoin = 0;
  int maxBounsWinCoin = 0;
  int creditCoin =0;
  late List<WinInfo> winInfos = [];
  late final bettingInfo = Map<String, int>();

  var ligthData = Map<int, RectangleComponent>();
  var ligthAniData = Map<int, RectangleComponent>();

  Vector2 startPosition = Vector2(10, 10);
  //const controllValues = [
  // 'Exit','Win <->Credit','Left Side','Right Side','Start',
  //];

  winCoinAni(int winCoin, bool? isDouble) async {
    //await creditCoinTextSprite.editTextValueAni(creditCoin -  bounsWinCoin );
    //清空押注項目的金額
    print("showWinCoin winCoin $winCoin");
    if (winCoin > 0) {
      
      bounsWinCoin = winCoin;
      await winCoinTextSprite.editTextValueAni(bounsWinCoin.toString());
      //比大小遊戲
      //顯示動畫
      if (isDouble == null) {
        await showWaitPlayLeftRightAni();
      }
      changeGameState( GameState.waitDoubleGame);
    } else {
      bounsWinCoin = 0;
      winCoinTextSprite.editTextValue(bounsWinCoin.toString());

     changeGameState(GameState.waitBit);
    }
    for (var item in bettingComponents) {
      print("bettingComponents.map");
      item.editTextValue("0");
    }
    maxBounsWinCoin = bounsWinCoin;
  }

  specialModel() {
    final winInfo = createWinItem(true)!;
    winInfos.add(winInfo);
    lightAniRun(
      ligthData,
      ligthAniData,
      startIndex,
      createWinItem(true)!.itemIndex,
      () {
        startIndex = lastIndex;
        winCoinAni(showWinCoin(winInfos, bounsWinCoin, null), null);
      },
    );
  }

  showWaitPlayLeftRightAni() async {
    await showLeftRight_LeftSide(ligthAniData, true);

    var lightType = lightColor_transparent;
    for (int j in LeftRight_LeftItems) {
      ligthAniData[j]?.paint.color = lightType;
    }
    for (int k in LeftRight_RightItems) {
      ligthAniData[k]?.paint.color = lightType;
    }
    leftSideBtn.ChangeBGColor(lightColor_ani1);
    rightSideBtn.ChangeBGColor(lightColor_ani1);
  }

  WinInfo? createWinItem(isSpecialModel) {
    WinInfo? winInfo;
    int rangeValue = isSpecialModel ? 24 : 25;

    var winIndex = Random().nextInt(isSpecialModel ? 24 : 25);
    print('startOnPressed lastIndex : $lastIndex ');

    if (isSpecialModel == true) {
      final onceMores = tableItemInfo.map((item) {
        return item.itemName == 'onceMore' && item.randomValue == winIndex;
      });
      if (onceMores.length > 0) {
        winIndex -= 1;
      }
    } else {
      if (winIndex == 25) {
        return winInfo;
      }
    }

    //錄得獎項目
    //bettingInfo[betStr] = betCoint;
    //itemIndex  取得對應的項目 tableItemInfo
    final items = tableItemInfo.where((item) {
      return item.randomValue == winIndex;
    });

    for (var itemInfo in items) {
      //是否有押注
      int? coins = bettingInfo[itemInfo.betId];
      coins ??= 0;
      //有押注
      winInfo = WinInfo(
        winIndex,
        itemInfo.betId,
        coins,
        coins * itemInfo.itemBettingMultiple,
      );
    }

    return winInfo;
  }

  startLeftRighGame(bool isLeftWin) async {
     changeGameState(GameState.startDoubleGame);
    final random = Random();
    var isLeftSide = (random.nextInt(100) % 2 == 1) ? true : false;
    await showLeftRight_LeftSide(ligthAniData, isLeftSide);
    bool checkValue = isLeftSide ? isLeftWin : !isLeftWin;
    winCoinAni(showWinCoin(winInfos, bounsWinCoin, checkValue), checkValue);
  }

   
  
   

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    localStorage = await LocalCreditCoin.create();
    creditCoin = localStorage.getLittleMary_CreditCoin();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

  createCoinInfoUI();

  await createBGAni();

  await createBettingUI();
   
  createControllerUI();


   
  }
  
 void changeGameState(GameState state){
//控制按鈕
    gameState = state;
    gameState.changeGameStateUI(
      exchangeBtn,
      winBtn,
      creditBtn,
      leftSideBtn,
      rightSideBtn,
      startBtn,
      bettingComponents,
      ligthData,
      ligthAniData,
      creditCoin,
      localStorage,
    );

//動畫項目
    
     
  }
  void exchangeOnPressed() async {
    if (gameState != GameState.waitDoubleGame) {
      return;
    }
    print('exchangeOnPressed');
    //win  to credit
    if (bounsWinCoin > 0) {
      winCoinTextSprite.editTextValueAni('0');
      creditCoin += bounsWinCoin;
      await creditCoinTextSprite.editTextValueAni(creditCoin.toString());
      changeGameState(GameState.waitBit);
    }
    //re set ui

  }
  
  void winOnPressed() async {
    if (gameState != GameState.waitDoubleGame) {
      return;
    }
    print('winOnPressed');
    //bouns-win to credit  
    if(maxBounsWinCoin > bounsWinCoin  ){
      bounsWinCoin += 1;
      winCoinTextSprite.editTextValueAni(bounsWinCoin.toString());
      creditCoin -=1;
      await creditCoinTextSprite.editTextValueAni(creditCoin.toString());
      
    }
    
  }

  void creditOnPressed() async {
    if (gameState != GameState.waitDoubleGame) {
      return;
    }
    print('creditOnPressed');
    //credit to bouns-wins
    if( bounsWinCoin > 1){
      bounsWinCoin -= 1;
      winCoinTextSprite.editTextValueAni(bounsWinCoin.toString());
      creditCoin +=1;
      await creditCoinTextSprite.editTextValueAni(creditCoin.toString());
      
    }
  }

  void leftSideOnPressed() {
    if (gameState != GameState.waitDoubleGame) {
      return;
    }
   
    print('leftSideOnPressed');
    startLeftRighGame(true);
  }

  void rightSideOnPressed() {
    if (gameState != GameState.waitDoubleGame) {
      return;
    }
    print('rightSideOnPressed');
    startLeftRighGame(false);
  }

  void startOnPressed() {
    if (gameState != GameState.waitStartGame) {
      return;
    }
    winInfos.clear();
    

    changeGameState(GameState.startGame);

    WinInfo? winInfo = createWinItem(false);
    if (winInfo == null) {
      //特殊模式
      winInfo = createWinItem(true)!;
      winInfos.add(winInfo);
      lightAniRun(ligthData, ligthAniData, startIndex, winInfo.itemIndex, () {
        startIndex = lastIndex;
        specialModel();
      });
    } else if (winInfo.winItemId == LitttleMaryItemName.once_more.name) {
      startIndex = lastIndex;
      winInfos.add(winInfo);
      //once more
      //執行動畫
      lightAniRun(
        ligthData,
        ligthAniData,
        startIndex,
        winInfo.itemIndex,
        () async {
          startIndex = lastIndex;
          await onceMore(ligthAniData);
          changeGameState(GameState.waitStartGame);
        },
      );
    } else {
      //正常模式
      //執行動畫
      winInfos.add(winInfo);
      lightAniRun(ligthData, ligthAniData, startIndex, winInfo.itemIndex, () {
        startIndex = lastIndex;
        winCoinAni(showWinCoin(winInfos, bounsWinCoin, null), null);
      });
    }
  }

  bool editBetting(int betCoint, String betStr) {
    print(
      'editBetting betStr: $betStr, betCoint:$betCoint  creditCoin: $creditCoin',
    );
    if ((gameState != GameState.waitBit) &&
        (gameState != GameState.waitStartGame)) {
      return false;
    }
    if (creditCoin == 0) return false;

    creditCoin -= 1;
    creditCoinTextSprite.editTextValue(creditCoin.toString());
    betCoint++;
    bettingInfo[betStr] = betCoint;
    changeGameState(GameState.waitStartGame);
    return true;
  }

  Future<List<Sprite>> createSpriteInfos(
    String tablePath,
    List<String> tableNames,
  ) async {
    List<String> tablePaths =
        tableNames.map((name) => '$tablePath$name.png').toList();

    final imageInfos = await images.loadAll(tablePaths);

    return imageInfos.map((imageInfo) {
      return Sprite(imageInfo, srcPosition: Vector2(0, 0));
    }).toList();
  }



//UI
void createCoinInfoUI(){
       final coinTitleSprite = createBettingTextSprite(
      BettingInfo,
      startPosition,
      Vector2(120, 50),
    );
    final coinTitleSpriteComponents = coinTitleSprite.$1;
    startPosition = coinTitleSprite.$2;
    coinTitleSpriteComponents.forEach((item) => world.add(item));

    final coinSprite = createBettingTextSprite(
      [bounsWinCoin.toString(), creditCoin.toString()],
      startPosition,
      Vector2(120, 50),
    );
    final coinSpriteComponents = coinSprite.$1;
    startPosition = coinSprite.$2;
    coinSpriteComponents.forEach((item) => world.add(item));
    winCoinTextSprite = coinSpriteComponents[0];
    winCoinTextSprite.editTextValue(bounsWinCoin.toString());
    creditCoinTextSprite = coinSpriteComponents[1];
    creditCoinTextSprite.editTextValue(creditCoin.toString());
  }

createBGAni()async{
     //加上燈號及小圖示
    //小圖示
    final tableGBInfos = await createSpriteInfos(
      bettingItemPath,
      tableBgImages,
    );

    final tableBGspriteComponents = createTableBGSpriteComponent(
      tableGBInfos,
      Vector2(120, 200),
    );
    for (final item in tableBGspriteComponents) {
      world.add(item);
    }
    ;

    // 添加背景动画系统
    bgAnimationSystem = BackgroundAnimationSystem(tableBGspriteComponents);

    add(bgAnimationSystem); //添加世界中才可以觸發onMount and update

    final spriteInfos = await createSpriteInfos(tablePath, tableNames);
    final playTableInfos = createPlayTablePosition(spriteInfos, startPosition);
    final playTableSpriteComponents = playTableInfos.$1;
    startPosition = playTableInfos.$2;
    playTableSpriteComponents.forEach((item) => world.add(item));

    //燈號
    ligthData = createLightDataItem(playTableSpriteComponents,world);

    ligthAniData = createLightAniDataItem(playTableSpriteComponents,world);

      

  }
   
createBettingUI() async{
    final bettingColorData = createBettingTextSprite(
      bettingTexts,
      startPosition,
      Vector2(120, 50),
    );
    final bettingColorComponents = bettingColorData.$1;
    startPosition = bettingColorData.$2;
    bettingColorComponents.forEach((item) => world.add(item));

    final bettingSpriteInfos = await createSpriteInfos(
      bettingItemPath,
      bettingItemNames,
    );
    final bettingInfos = createBettingPosition(
      bettingSpriteInfos,
      startPosition,
    );
    final bettingSpriteComponents = bettingInfos.$1;
    print('bett1 $startPosition');
    startPosition = bettingInfos.$2;

    bettingSpriteComponents.forEach((item) => world.add(item));
    print('bett2 $startPosition');
    //startPosition.y  += 120;
    final bettingData = createBettingTapEditSprite(
      bettingItemNames,
      startPosition,
      editBetting,
    );
    bettingComponents = bettingData.$1;
    startPosition = bettingData.$2;
    bettingComponents.forEach((item) => world.add(item));
   }


createControllerUI( ){
   //controller ui

    //  添加一个自定义的HUD按钮，位置在屏幕右上角  'Exit','Win', 'Credit','Left Side','Right Side','Start',

    startPosition.y += 20;
    exchangeBtn = createControllButton(
      world,
      controllValues[0],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      exchangeOnPressed,
    );
    startPosition.x += 130;
    winBtn = createControllButton(
      world,
      controllValues[1],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      winOnPressed,
    );
    startPosition.x += 130;
    creditBtn = createControllButton(
      world,
      controllValues[2],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      creditOnPressed,
    );
    startPosition.x += 130;
    leftSideBtn = createControllButton(
      world,
      controllValues[3],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      leftSideOnPressed,
    );
    startPosition.x += 130;
    rightSideBtn = createControllButton(
      world,
      controllValues[4],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      rightSideOnPressed,
    );
    startPosition.x += 130;
    startBtn = createControllButton(
      world,
      controllValues[5],
      controllValues[0],
      startPosition,
      Vector2(120, 120),
      startOnPressed,
    );

    changeGameState(gameState);
   
}
    
 

}
