


import 'package:ios_flutter/view/game/little_mary/config.dart';


int showWinCoin(List<WinInfo> winInfos, int bounsWinCoin,bool? isDouble) {
  int winCoin = 0;
  if(isDouble == true){
    winCoin =  bounsWinCoin * 2;

  }else if(isDouble == false){
    winCoin = 0;
  }else{ //if(isDouble == null){
    
    print('showWinCoin winInfos.leght ${winInfos.length}');
    winInfos.forEach((item){
      winCoin += item.winCoin;

    });
  }
  return winCoin;
}
 