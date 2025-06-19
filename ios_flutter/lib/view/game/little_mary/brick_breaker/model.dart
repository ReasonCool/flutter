

import 'package:ios_flutter/view/game/little_mary/config.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
 
//localInof
class LocalCreditCoin {
  final SharedPreferences prefs;

  // Private constructor that accepts an initialized SharedPreferences instance
  LocalCreditCoin._(this.prefs);

  // Static async factory method to create an instance
  static Future<LocalCreditCoin> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalCreditCoin._(prefs);
  }

  Future<void> setLittleMary_CreditCoin(int creditCoin) async {
    await prefs.setInt(LittleMary_CreditCoin_LocalKey, creditCoin);
  }

  int getLittleMary_CreditCoin() {
    
     int creditCoin =  prefs.getInt(LittleMary_CreditCoin_LocalKey)??100;
    
   return creditCoin;
  }

}






 