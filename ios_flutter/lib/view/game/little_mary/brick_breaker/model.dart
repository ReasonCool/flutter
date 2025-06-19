
import 'dart:math';
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
 
int getWinNumber(bool isSpecialModel){
  int winIndex = 0;
  int selTime = 0;
  while(winIndex == 0 || selTime < 10 ){
    winIndex = getWinNumber_part1(isSpecialModel);
    selTime += 1;
    print('do while time$selTime');
  }
  if(winIndex == 0){
     winIndex = Random().nextInt(24);
     print('do while winIndex $winIndex');
  }
   print('do while return winIndex $winIndex');
  return winIndex;

}

int getWinNumber_part1(bool isSpecialModel)
{
   //int rangeValue = isSpecialModel ? 24 : 25;
     
    var randomNumber = Random().nextInt(1000);

    int  selectOneWithTwo(int rangeValue,int firstValue, int secondValue){
       int check = Random().nextInt(rangeValue);
      if(check%2==0){
        return firstValue;
      }else{
        return secondValue;
      }
     }
     int  selectOneWithThird(int rangeValue,int firstValue, int secondValue,int thirdValue){
       int check = Random().nextInt(rangeValue);
      if(check%3==0){
        return firstValue;
      }else if(check%3==1){ 
        return secondValue;
      }else{
        return thirdValue;
      }
     }

     int  selectOneWithFour(int rangeValue,int firstValue, int secondValue,int thirdValue,int fourValue){
       int check = Random().nextInt(rangeValue);
      if(check%4==0){
        return firstValue;
      }else if(check%4==1){ 
        return secondValue;
      }else if(check%4==2){ 
        return thirdValue;
      }else{
        return fourValue;
      }
     }

  if(randomNumber%100 == 0){
   return 4;
  }  
  if(isSpecialModel == true && randomNumber%90 == 0){
    //special model
   return 25;
  }  
  if(randomNumber%80 == 0){
   return 15;
  }  
  if(randomNumber%70 == 0){
    //once more
    return selectOneWithTwo(20,10, 22);
  }  
  if(randomNumber%60 == 0){
   return 21;
  } 
  if(randomNumber%50 == 0){
    return selectOneWithTwo(20,9, 3);
  }  
  if(randomNumber%40 == 0){
   return selectOneWithTwo(20, 16, 24);
  } 
  if(randomNumber%30 == 0){
   return selectOneWithTwo(20, 20, 18);
  }
  if(randomNumber%25 == 0){
    return selectOneWithTwo(20, 8, 5);
  }
  if(randomNumber%20 == 0){
    return selectOneWithThird(20, 2, 12, 14);
  } 
  if(randomNumber%15 == 0){
       return selectOneWithTwo(20, 7, 19);
  }  
  if(randomNumber%10 == 0){
     return selectOneWithTwo(20, 1, 13);
  }
  if(randomNumber%5 == 0){
     return selectOneWithFour(20,6,11,17,23);
  }
 
  return 0;
   
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






 