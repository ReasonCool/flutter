import 'package:flutter/material.dart';
//左側功能 項目
 enum MenuItemName{
  login('Login'),
  logout('Logout'),
  setting('Setting'),
  abouUs('About'),
  loginFB('LoginFB'),
  loginGoogle('loginGoogle'),
  loginApple('loginApple'),
  loginEmail('loginEmail'),
  loginAuto('loginAuto');


  final String itemName;
  const MenuItemName(this.itemName);

  static Map<String,Widget> popItems = { 
    MenuItemName.setting.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text("設定")],),) ,
    MenuItemName.abouUs.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.info ,color: Colors.green),Text("關於")],),) ,
      };


  static  Map<String,Widget>get popItemsIsLogin => { 
    MenuItemName.login.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text(MenuItemName.login.itemName)],),) ,
    ...popItems      };

    static  Map<String,Widget>get popItemsIsLogout => { 
    MenuItemName.logout.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text(MenuItemName.logout.itemName)],),) ,
   ...popItems       };

  static  Map<String,Widget>get popLoginItems => {
   // MenuItemName.loginFB.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.facebook,color: Colors.green),Text("Facebook")],),) ,
   // MenuItemName.loginApple.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.apple ,color: Colors.green),Text("Apple")],),) ,
    MenuItemName.loginEmail.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.email ,color: Colors.green),Text("Email")],),) ,
    MenuItemName.loginAuto.itemName:SizedBox(width: 120,height: 50,child: Row(children: [Icon(Icons.auto_awesome ,color: Colors.green),Text("Auto")],),) ,
 
  };

  static List<String>get allMenuItemName =>  [
    MenuItemName.login.itemName,
    MenuItemName.setting.itemName,
    MenuItemName.abouUs.itemName,
    MenuItemName.loginFB.itemName,
    MenuItemName.loginApple.itemName,
    MenuItemName.loginEmail.itemName,
    MenuItemName.loginAuto.itemName, 
  ];

 } 
