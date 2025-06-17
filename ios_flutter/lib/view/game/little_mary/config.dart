
 
import 'dart:ui';

import 'package:ios_flutter/view/game/little_mary/item.dart';

const gameWidth = 820.0;
const gameHeight = 1500.0;
const itemWidth = gameWidth/7;
const itemHeight = itemWidth;


const tablePath = 'resource/images/little_mary/table/';
   
const tableNames = [
       'orange','bell','bar50','bar','bar25','apple','melon',
       'bell_multiple_2', 'water_melon',
       'apple','water_melon_multiple_2',
       'once_more', 'once_more', 
       'star_multiple_2', 'apple',
       'star','orange_multiple_2',
       'melon','melon_multiple_2','apple','seven','seven_multiple_2','bell','orange',
    ];
const bettingItemPath = 'resource/images/little_mary/';
const tableBgImages = [
  'left_right_bg001','left_right_bg002','left_right_bg003',
];


enum LitttleMaryItemName   {
 orange,bell,bar50,bar,bar25,apple,melon,
       bell_multiple_2, water_melon,
      water_melon_multiple_2,
       once_more, 
       star_multiple_2, 
       star,orange_multiple_2,
     seven,seven_multiple_2;

}

 
const bettingValues = [
  '00','00','00','00','00','00','00','00',
];

const controllValues = [
 'Exchange','Win', 'Credit','Left Side','Right Side','Start',
];
const BettingInfo = [
  'BOUNS-WIN','CREDIT',
];

  const lightColor_transparent = Color.fromARGB(0, 255, 255, 255);
    const lightColor_selected = Color.fromARGB(100, 0, 255,0);
  const lightColor_ani1 = Color.fromARGB(100, 231, 0,0);
  const lightColor_ani2 = Color.fromARGB(50, 231, 0,0);
const lightColor_background = Color.fromARGB(255, 148, 132, 171);


const tableItemKey = [
       1,2,3,4,5,6,7,24,8,23,9,22,10,21,11,20,12,19,18,17,16,15,14,13,
    ];
class ItemInfo {
  
  final int randomValue;
  final String betId;
  final String itemName;
  final int itemBettingMultiple;
  const ItemInfo( this.randomValue,this.betId,this.itemName,this.itemBettingMultiple);
} 

const List<ItemInfo>tableItemInfo = [
 // ItemInfo(1, 1, itemName, itemBettingMultiple)
   
      ItemInfo(1, 'orange','orange',10),
      ItemInfo(2, 'bell', 'bell',20),
      ItemInfo(3, 'bar', 'bar50',50),
      ItemInfo(4,  'bar','bar',100),
      ItemInfo(5, 'bar','bar25',25),
      ItemInfo(6,   'apple','apple',5),
      ItemInfo(7,  'melon', 'melon',15),
      ItemInfo(24, 'bell', 'bell_multiple_2',40),
      ItemInfo(8,   'water_melon', 'water_melon',25),
      ItemInfo(23,  'apple', 'apple',5),
      ItemInfo(9,  'water_melon', 'water_melon_multiple_2',50),
      ItemInfo(22,  'once_more','once_more',0),
      ItemInfo(10,  'once_more', 'once_more', 0),
      ItemInfo(21,  'star', 'star_multiple_2',60),
      ItemInfo(11,  'apple',  'apple',5),
      ItemInfo(20,  'star', 'star',30),
      ItemInfo(12, 'orange', 'orange_multiple_2',20),
      ItemInfo(19,  'melon', 'melon',1),
      ItemInfo(18,  'melon', 'melon_multiple_2',30),
      ItemInfo(17,  'apple',  'apple',5),
      ItemInfo(16,'seven', 'seven',40),
      ItemInfo(15, 'seven', 'seven_multiple_2',80),
      ItemInfo(14,'bell',  'bell',20),
      ItemInfo(13,'orange','orange',10),
    ];
const bettingTexts = [
  '100','40','30','25','20','15','10','5',
];
const bettingItemNames = [
  'bar','seven','star','water_melon','bell','melon','orange','apple',
];

 
 final LeftRight_Speed = 400;
  final LeftRight_LeftItems = [1,2,3,4,24,23,22,21,20,19,18,17,16];
  final LeftRight_RightItems = [4,5,6,7,8,9,10,11,12,13,14,15,16];
 


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