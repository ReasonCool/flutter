

import 'package:flutter/material.dart';
import 'package:ios_flutter/home/app_context.dart';


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
      
    );
  }
}
    



