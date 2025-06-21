

import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/app_context.dart';

//provider
import 'package:provider/provider.dart';
import 'package:ios_flutter/model/loginInfo.dart';

 


 import 'package:ios_flutter/future/firebase_init.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

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


 
void main() async {

WidgetsFlutterBinding.ensureInitialized(); // 確保 Flutter 綁定
  await MobileAds.instance.initialize();     // 初始化 AdMob SDK
 
runApp(  
  //admob
  //provider
  MultiProvider( // 正确使用 MultiProvider
        providers: [
          ChangeNotifierProvider(create: (_) => LoginModel()),
          // 添加其他 Provider...
        ],
        child:const MyApp()
      )
    );

//runApp(const MyApp());


}
Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
// 动态路由生成器：路由名稱無對應資料會跑這個
  // Route<dynamic>? _generateRoute(RouteSettings settings) {
 
  //   // 统一处理路由参数 final args = settings.arguments;
 
    
  // }
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState(); 
}
class _MyAppState extends State<MyApp>{
late Future <Map<String, dynamic>> _firebase_Init;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebase_Init = firebaseInit();

    //admob
   _initGoogleMobileAds(); // This initializes the SDK
    
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, dynamic>>(
      future: _firebase_Init,
      builder: (context, snapshot) {
        // 顯示載入動畫
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        // 錯誤處理
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } 

        // // 取得資料後的顯示
          final data = snapshot.data!; 
          print("data['providerId'] ${data['providerId']}");

          // 延遲到當前 Frame 結束後再更新狀態
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("addPostFrameCallback");
          context.read<LoginModel>().setProviderId(data['providerId']);
        });
          //context.read<LoginModel>().setProviderId(data['providerId']);
        return  MaterialApp(
          title: 'Counter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          //home: const HomePage(),
          initialRoute: AppRoutes.homeName.path,
          routes: AppRoutes.routes ,
        // onGenerateInitialRoutes: (RouteSettings settings) => _generateRoute(settings),
          navigatorObservers: [MyNavigatorObserver()],
        );
      }
    );
  }
}
    


 