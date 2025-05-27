import 'package:flutter/material.dart';
import 'package:ios_flutter/view/home/home.dart';
import 'package:ios_flutter/view/game/game_screen.dart';

import 'package:ios_flutter/view/login/auto_login_page.dart';
import 'package:ios_flutter/view/login/email_login_page.dart';
import 'package:ios_flutter/view/login/email_regist_page.dart';

import 'package:ios_flutter/view/sub_page/remote_config_page.dart';
import 'package:ios_flutter/view/sub_page/notification_page.dart';
import 'package:ios_flutter/view/sub_page/provider_page.dart';
import 'package:ios_flutter/view/sub_page/provider_sdk_page.dart';
import 'package:ios_flutter/view/sub_page/inherited_widget_page.dart';
import 'package:ios_flutter/view/sub_page/flow_page.dart';
import 'package:ios_flutter/view/sub_page/widgets_binding_page.dart';
import 'package:ios_flutter/view/sub_page/tap_page.dart';
import 'package:ios_flutter/view/sub_page/dialog_page.dart';
import 'package:ios_flutter/view/sub_page/fitted_box_page.dart';
import 'package:ios_flutter/view/sub_page/clip_page.dart';
import 'package:ios_flutter/view/sub_page/trasform_rotate_box_page.dart';
import 'package:ios_flutter/view/sub_page/widgets_binding_page.dart';
import 'package:ios_flutter/view/sub_page/layout_build_page.dart';
import 'package:ios_flutter/view/sub_page/align_page.dart';
import 'package:ios_flutter/view/sub_page/decorated_box_page.dart';
import 'package:ios_flutter/view/sub_page/progress_Indicator_page.dart';
import 'package:ios_flutter/view/sub_page/text_page.dart'; 
import 'package:ios_flutter/view/sub_page/textFromField/form_page.dart';
import 'package:ios_flutter/view/sub_page/textField/textfield_page.dart'; 
import 'package:ios_flutter/view/sub_page/switch_check_page.dart'; 
import 'package:ios_flutter/view/sub_page/button_page.dart'; 
import 'package:ios_flutter/view/sub_page/icon_page.dart'; 
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
import 'package:ios_flutter/view/sub_page/wrap_page.dart';

/// 路由配置表
/// ----------------------------
 
enum AppRoutes {
  homeName('/HomeName'),
  game1Name('/Game1Name'),
  emailRegistPageName('/EmailGegistPageName'),
  autoLoginName('/AutoLoginName'),
  remoteConfigPageName('/RemoteConfigPageName'),
  notificationPageName('/NotificationPageName'),
  inheritedWidgetPageName('/InheritedWidthPageName'),
  providerPageName('/ProviderPageName'),
  providerSDKPageName('/ProviderSDKPageName'),
  flowPageName('/FlowPageName'),
  wrapPageName('/WrapPageName'),
  tapPageName('/TapPageName'),
  dialogPageName('/DialogPageName'),
  emailLoginPage('/EmailLoginPage'),
  clipPage('/ClipPage'),
  fittedBoxPageName('/FittedBoxPageName'),
  transformRotateBoxPage('/TransformRotateBoxPage'),
  widgetsBindingPage('/WidgetsBindingPage'),
  layoutBuildPageName('/LayoutBuildPageName'),
  decoratedBoxPageName('/DecoratedBoxPageName'),
  alignPageName('/AlignPageName'),
  progressIndicatorName('/ProgressIndicatorName'),
  textPageName('/TextPageName'),
  textFieldPageName('/TextFieldPageName'),
  formPageName('/FormPageName'),
  switchCheckPageName('/SwitchCheckPageName'),
  iconPageName('/IconPageName'),
  buttonPageName('/ButtonPageName'),
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
  game1Name.path:(_) => GameScreen(),
  emailRegistPageName.path: (_) => const EmailRegistPage(),
  autoLoginName.path: (_) => const AutoLoginPage(),
  remoteConfigPageName.path: (_) => const RemoteConfigPage(),
  notificationPageName.path: (_) => NotificationPage(),
  providerPageName.path: (_) => const ProviderPage(),
  providerSDKPageName.path: (_) => const ProviderSdkPage(),
  inheritedWidgetPageName.path: (_) => const InheritedWidgetPage(),
  flowPageName.path:(_)=> const FlowPage(),
  wrapPageName.path:(_)=> const WrapPage(),
  tapPageName.path:(_) => const TapPage(),
  dialogPageName.path : (_) => const DialogPage(),
  emailLoginPage.path: (_) => const EmailLoginPage(),
  fittedBoxPageName.path: (_) => const FittedBoxPage(),
  clipPage.path: (_) => const ClipPage(),
  transformRotateBoxPage.path: (_) => const TransformRotateBoxPage(),
  widgetsBindingPage.path: (_) => const WidgetsBindingPage(),
  layoutBuildPageName.path: (_) => const LayoutBuildPage(),
  decoratedBoxPageName.path:(_)=>const DecoratedBoxPage(),
  alignPageName.path: (_) => const AlignPage(),
  progressIndicatorName.path: (_) => const ProgressIndicatorPage(),
  textPageName.path: (_) => const TextPage(),
  formPageName.path:(_) => const FormPage(),
  textFieldPageName.path: (_) => const TextFieldPage(),
  switchCheckPageName.path: (_) =>  SwitchCheckPage(),
  iconPageName.path: (_) => const IconPage(),
  buttonPageName.path: (_) => const ButtonPage(),
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
    //autoLoginName.path:{"title":"auto login Page "},
    game1Name.path:{"title":"Game 1"},
    emailRegistPageName.path:{'title':'Email 登錄 '},
    remoteConfigPageName.path:{"title":"Romte Config Page "},
    notificationPageName.path:{"title":"notification Page "},
    providerPageName.path:{"title":"provider Page "},
    providerSDKPageName.path:{"title":"provider sdk Page "},
    inheritedWidgetPageName.path:{"title":"Inherited 簡單做"},
    flowPageName.path:{"title":"Flow Page "},
    clipPage.path:{'title':'clip 剪裁 '},
    wrapPageName.path:{'title':'Wrap Page'},
    dialogPageName.path:{'title':'對話匡 '},
    tapPageName.path:{'title':'Tab Page '},
    emailLoginPage.path : {'title':'Email Login '},
     fittedBoxPageName.path:{'title':'溢出空間調整 '},
    transformRotateBoxPage.path:{'title':'transform rotateBox 旋轉與平移 '},
    widgetsBindingPage.path:{'title':'Widget渲染後的尺寸與位置 '},
    layoutBuildPageName.path:{'title':'Layout Build Page 取得設備尺寸 '},
    decoratedBoxPageName.path:{'title':'DecoratedBox '},
    alignPageName.path: {"title":"align定位"},
    progressIndicatorName.path: {"title":"進度與等待"},
    imageTestName.path: {"title":"本地與遠端圖片"} ,
    textPageName.path : {"title":"Text"},
     textFieldPageName.path : {"title":"TextField"},
     formPageName.path: {"title":"FormPage"},
    switchCheckPageName.path : {"title":"SwitchCheckBox"},
    iconPageName.path : {"title":"Icon"},
    buttonPageName.path : {"title":"Button"},
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