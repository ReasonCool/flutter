
import '../contain/button_tap.dart';
enum GameState{

  waitBit(10),waitStartGame(20),startGame(25),waitDoubleGame(30),startDoubleGame(40);



  const GameState(this.enumValue); 

  


  final int enumValue;
}

extension buttonState on GameState{ 
   
//controller button
  void   editControllerButton(
    HudCustomButton exchangeBtn,
    HudCustomButton winBtn,
    HudCustomButton creditBtn,
    HudCustomButton leftSideBtn,
    HudCustomButton rightSideBtn,
    HudCustomButton startBtn,
    //GameState gameState,
   ){

    // Reset all buttons to default state (adjust as needed)
    final buttons = [exchangeBtn, winBtn, creditBtn, leftSideBtn, rightSideBtn, startBtn];
    for (final button in buttons) {
       button.ChangeEnable(false);
      
    }

  switch (this){
    case GameState.waitBit:
          
      break;
    case GameState.waitStartGame:
        
      startBtn.ChangeEnable(true);
      break;
    case GameState.startGame:

      break;
    case GameState.waitDoubleGame:
      exchangeBtn.ChangeEnable(true);
      winBtn.ChangeEnable(true);
      creditBtn.ChangeEnable(true);
      leftSideBtn.ChangeEnable(true);
      rightSideBtn.ChangeEnable(true);
      break;
    case GameState.startDoubleGame:

      break;  
    default:  
       break;   

  };
       

  }
}