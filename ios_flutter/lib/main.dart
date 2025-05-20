

import 'package:flutter/material.dart';
import 'package:ios_flutter/constant/app_context.dart';
 
 


//檢測頁面狀態
class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 当新页面被推入路由栈时触发
    print('进入新页面: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 当页面被弹出路由栈时触发
    print('返回上一页: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // 当页面被直接移除时触发
    print('移除页面: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // 当页面被替换时触发（如调用 replace 方法）
    print('替换页面: ${oldRoute?.settings.name} → ${newRoute?.settings.name}');
  }
}


void main() {
  
  runApp(const MyApp());



}

// 动态路由生成器：路由名稱無對應資料會跑這個
  // Route<dynamic>? _generateRoute(RouteSettings settings) {
 
  //   // 统一处理路由参数 final args = settings.arguments;
 
    
  // }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'Counter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: const HomePage(),
      initialRoute: AppRoutes.homeName.path,
      routes: AppRoutes.routes ,
     // onGenerateInitialRoutes: (RouteSettings settings) => _generateRoute(settings),
      navigatorObservers: [MyNavigatorObserver()],
    );
  }
}
    


 