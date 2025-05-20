  /**
   * 首頁畫面
   * 
   * 
   */


import 'package:flutter/material.dart';
import 'package:ios_flutter/view/home/home_model.dart';
import 'package:ios_flutter/view/home/menu_page.dart';
import 'package:ios_flutter/view/home/drawer_page.dart';

//主畫面
class HomePage extends StatelessWidget {
  const HomePage({super.key}); 

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: const Text('功能展示'),backgroundColor: Colors.red,
      leading: homeLeftMenu(context),
       ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0 ,onTap: (index) {
          createDialog(context);
        },
      type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: [
        BottomNavigationBarItem( icon:  Icon( Icons.functions,color: Colors.green), backgroundColor: Colors.black,label: '功能展示'),
        BottomNavigationBarItem( icon:  Icon( Icons.add,color: Colors.green), backgroundColor: Colors.black,label: '增加'),
        BottomNavigationBarItem( icon:  Icon( Icons.settings_backup_restore,color: Colors.green), backgroundColor: Colors.black,label: '註冊'),
        ],),
       drawer: MyDrawer(),
       endDrawer: MyDrawer(),
       floatingActionButton: FloatingActionButton(onPressed :() =>  createDialog(context)  ,child: Text("FloatingButton"),),
     //extendBodyBehindAppBar: true, // 允许内容延伸到AppBar下方
      body:Center(child: 
       Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 0,
            child:Text("取得目前裝置寬度 screenWidth = MediaQuery.of(context).size.width;")
            ,),
            
           Divider(),

            Expanded(
              flex: 1,
              child: buildAddBgImage(context),
            
           
        ),
      ]),
      )
      );
    
      
    
  }
}
