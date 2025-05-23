import 'package:flutter/material.dart';
import 'package:ios_flutter/constant/app_context.dart';
 
 //provider
import 'package:provider/provider.dart';
import 'package:ios_flutter/model/loginInfo.dart';

import 'package:ios_flutter/future/firebase_logout.dart';


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
    MenuItemName.setting.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text("設定")],),) ,
    MenuItemName.abouUs.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.info ,color: Colors.green),Text("關於")],),) ,
      };


  static  Map<String,Widget>get popItemsIsLogin => { 
    MenuItemName.login.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text(MenuItemName.login.itemName)],),) ,
    ...popItems      };

    static  Map<String,Widget>get popItemsIsLogout => { 
    MenuItemName.logout.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.settings,color: Colors.green),Text(MenuItemName.logout.itemName)],),) ,
   ...popItems       };

  static  Map<String,Widget>get popLoginItems => {
   // MenuItemName.loginFB.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.facebook,color: Colors.green),Text("Facebook")],),) ,
   // MenuItemName.loginApple.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.apple ,color: Colors.green),Text("Apple")],),) ,
    MenuItemName.loginEmail.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.email ,color: Colors.green),Text("Email")],),) ,
    MenuItemName.loginAuto.itemName:Container(width: 120,height: 50,child: Row(children: [Icon(Icons.auto_awesome ,color: Colors.green),Text("Auto")],),) ,
 
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

PopupMenuButton<String> homeLeftMenu( BuildContext context ){


  Map<String,Widget> popItems  = context.watch<LoginModel>().isLogin ?  MenuItemName.popItemsIsLogout : MenuItemName.popItemsIsLogin;
  Map<String,Widget> popLoginItems   = MenuItemName.popLoginItems;

  menuOnSelectedItem(itemName)  {

     print("menuOnSelectedItem $itemName");


    if(itemName == MenuItemName.loginAuto.itemName){
      Navigator.of(context).pushNamed(AppRoutes.autoLoginName.path );
    }else if(itemName == MenuItemName.loginFB.itemName){
        Navigator.of(context).pushNamed(AppRoutes.emailLoginPage.path );
    }else  if(itemName == MenuItemName.logout.itemName){
      /// TODO :改為登出狀態
      //弹出对话框并等待其关闭 showLogout
      showLogout(context);
     
    }

};


 final List<PopupMenuItem<String>> popLoginList = popLoginItems.entries.map((entry) => PopupMenuItem<String> (
          value: entry.key,
          child: entry.value,
        ), 
    ).toList();


   return PopupMenuButton<String>(
      icon: const Icon(Icons.menu), // 自定义图标
         offset: const Offset(0, 56),
          itemBuilder: (context) => popItems.entries.map((entry) => PopupMenuItem<String> (
          value: entry.key,
          child: entry.value,
          onTap: ()   {
            if(entry.key == MenuItemName.login.itemName){
              final renderBox = context.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero);
            // 显示二级菜单
              final loginType =   showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx + 120,
                  offset.dy + 56,
                  offset.dx + 120 * 2,
                  offset.dy + 50,
                ),
                 items:  popLoginList,
                 
                 ).then((value){
                   menuOnSelectedItem(value);
                  //    if (value == 'option1') {
                  //   Navigator.pushNamed(context, '/page1');
                  // }
                 } 
                 ) ;
            }
            
          },
        ), 
    ).toList(),
          onSelected: (value) async {
            print("onSelected $value");

             
            // 处理菜单项点击
              menuOnSelectedItem(value);
          },
    
        );
}