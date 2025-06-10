import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/home_left_page_enum.dart';
import 'package:ios_flutter/enum/app_context.dart';
 //provider
import 'package:provider/provider.dart';
import 'package:ios_flutter/model/loginInfo.dart';
import 'package:ios_flutter/future/firebase_logout.dart';


PopupMenuButton<String> homeLeftMenu( BuildContext context ){


  Map<String,Widget> popItems  = context.watch<LoginModel>().isLogin ?  MenuItemName.popItemsIsLogout : MenuItemName.popItemsIsLogin;
  Map<String,Widget> popLoginItems   = MenuItemName.popLoginItems;

  menuOnSelectedItem(itemName)  {

     print("menuOnSelectedItem $itemName");


    if(itemName == MenuItemName.loginAuto.itemName){
      Navigator.of(context).pushNamed(AppRoutes.autoLoginName.path );
    }else if(itemName == MenuItemName.loginEmail.itemName){
        Navigator.of(context).pushNamed(AppRoutes.emailLoginPage.path );
    }else  if(itemName == MenuItemName.logout.itemName){
      /// TODO :改為登出狀態
      //弹出对话框并等待其关闭 showLogout
      showLogout(context);
     
    }

}


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