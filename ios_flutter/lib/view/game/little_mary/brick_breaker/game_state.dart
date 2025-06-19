
import '../contain/button_tap.dart';
import '../contain/betting_tap.dart';
import 'package:flame/components.dart';
import 'model.dart';
import '../config.dart';
enum GameState{

  waitBit(10),waitStartGame(20),startGame(25),waitDoubleGame(30),startDoubleGame(40);



  const GameState(this.enumValue); 

  

  final int enumValue;
}

extension buttonState on GameState{ 
   
//controller button
  void   changeGameStateUI(
    HudCustomButton exchangeBtn,
    HudCustomButton winBtn,
    HudCustomButton creditBtn,
    HudCustomButton leftSideBtn,
    HudCustomButton rightSideBtn,
    HudCustomButton startBtn,
   List<ColoredTapTextSprite> bettingTaps,
   Map<int,RectangleComponent> lightData,
  Map<int,RectangleComponent> lightAniData,
  int creditCoin,
   LocalCreditCoin localStorage,
   ){

    // Reset all buttons to default state (adjust as needed)
    final buttons = [exchangeBtn, winBtn, creditBtn, leftSideBtn, rightSideBtn, startBtn];
    for (final button in buttons) {
       button.changeEnable(false);
      
    }
    bettingTapsEnable(isEnable){
      for (final button in bettingTaps) {
       button.changeEnable(isEnable);
      
      }
    }
     resetLightColor() {
        var lightType = lightColor_transparent;
        for (int j in LeftRight_LeftItems) {
          lightAniData[j]?.paint.color = lightType;
          lightData[j]?.paint.color = lightType;
        }
        for (int k in LeftRight_RightItems) {
          lightAniData[k]?.paint.color = lightType;
          lightData[k]?.paint.color = lightType;
        }
      }   
      resetLightColor();
      

  switch (this){
    case GameState.waitBit:
        localStorage.setLittleMary_CreditCoin(creditCoin);
        bettingTapsEnable(true);
      break;
    case GameState.waitStartGame:
         bettingTapsEnable(true);
      startBtn.changeEnable(true);
      break;
    case GameState.startGame:
     localStorage.setLittleMary_CreditCoin(creditCoin);
      bettingTapsEnable(false);
      break;
    case GameState.waitDoubleGame:
      bettingTapsEnable(false);
      exchangeBtn.changeEnable(true);
      winBtn.changeEnable(true);
      creditBtn.changeEnable(true);
      leftSideBtn.changeEnable(true);
      rightSideBtn.changeEnable(true);
      break;
    case GameState.startDoubleGame:
      localStorage.setLittleMary_CreditCoin(creditCoin);
      bettingTapsEnable(false);
      break;  
    default:  
       break;   

  };
   

  }
}
