import 'package:flutter/material.dart';
import 'package:ios_flutter/home/home.dart';
import 'package:ios_flutter/view/sub_page/count_page.dart';
import 'package:ios_flutter/view/sub_page/image_page.dart';
import 'package:ios_flutter/view/sub_page/container_page.dart';
import 'package:ios_flutter/view/sub_page/flex_page.dart';
import 'package:ios_flutter/view/sub_page/list_page.dart';
import 'package:ios_flutter/view/sub_page/state_lift_cycle.dart';
import 'package:ios_flutter/view/sub_page/scaffold_message.dart';
import 'package:ios_flutter/view/sub_page/stack_page.dart';
import 'package:ios_flutter/view/sub_page/gusture_detector.dart';
import 'package:ios_flutter/view/sub_page/child_change_state_page.dart';
import 'package:ios_flutter/view/sub_page/navi_transfor_data.dart';
import 'package:ios_flutter/view/sub_page/navi_transfor_data_stateful.dart';

/// 路由配置表
/// ----------------------------
 
enum AppRoutes {
  homeName('/HomeName'),
  imageTestName('/ImageTestName'),
  stateLiftCycleName('/StateLiftCycleName'),
  counterPageName('/CounterPageName'),
  containerPageName('/ContainerPageName'),
  flexPageName('/FlexPageName'),
  listPageName('/ListPageName'),
  scaffoldMessageName('/ScaffolMessageName'),
  stackPageName('/StackPageName'),
  gustureDetectorName('/GustureDetectorName'),
  switchStateName('/SwitchStateName'),
  navigatorTransforDataName('/NavigatorTransforDataName'),
 navigatorTransforDataStatefulName('/NavigatorTransforDataStatefulName');

  final String path;
  const AppRoutes(this.path);

  
 //設定畫面路由名稱與路由對應
  static Map<String,WidgetBuilder> get routes =>{
  homeName.path: (_) => const HomePage(),
  imageTestName.path: (_) => const ImagePage(),
  stateLiftCycleName.path : (_) => const StateLifecycleTest(),
  counterPageName.path : (_) =>  const CounterPage(),
  containerPageName.path : (_) =>   const  ContainerPage(),
  flexPageName.path : (_) =>  const   FlexPage(),
  listPageName.path : (_) =>   const  ListPage(),
  scaffoldMessageName.path : (_) =>  const  ScaffoldMessagePage(),
  stackPageName.path : (_) => const StackPage(),
  gustureDetectorName.path : (_) =>    TapboxA(),
  switchStateName.path : (_) =>   ParentWidget(),
  navigatorTransforDataName.path: (_) => NaviTransforData(),
  navigatorTransforDataStatefulName.path: (_) => NavigatorTransforDataSateful(),
  }; 

  //設定按鈕的顯示名稱與路由名稱對應

  static Map<String,Map<String,String>> get rountNames => {
    //homeName.path: "首頁",arg
    imageTestName.path: {"title":"本地與遠端圖片"} ,
    stateLiftCycleName.path : {"title":"狀態生命週期"},
    counterPageName.path : {"title":"狀態變化：計數展示"},
    containerPageName.path : {"title":"容器 container "},
    flexPageName.path : {"title":"容器 flex 佔比分割"},
    listPageName.path : {"title":"容器 List"},
    scaffoldMessageName.path : {"title":"資料 抓取上層資料"},
    stackPageName.path : {"title":"容器 疊加畫面"},
    gustureDetectorName.path : {"title":"手勢 點擊"},
    switchStateName.path : {"title":"狀態 狀態傳遞"},
    navigatorTransforDataName.path: {"title":"Navigator stateless 傳遞與回拋資料 ","arg":"navigator Stateless","wait":"wait"},
    navigatorTransforDataStatefulName.path: {"title":"Navi stateful 傳遞與回拋資料 ","arg":"navigator Stateful","wait":"wait"},
  };

     
}