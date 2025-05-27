 
import 'package:flutter/material.dart';
import 'package:ios_flutter/future/firebase_login.dart';
import 'package:ios_flutter/model/loginInfo.dart';
import 'package:provider/provider.dart';
import 'package:ios_flutter/enum/login_type_enum.dart';
 

class AutoLoginPage extends StatefulWidget{
  const AutoLoginPage ({Key? key}): super (key:key);

  @override
  State<AutoLoginPage> createState() => _AutoLoginPage(); 
}
class _AutoLoginPage extends State<AutoLoginPage>{
 late Future<Map<String, dynamic>> _nonNameLogin;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nonNameLogin = firebase_autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auto Login 1")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _nonNameLogin,
        builder: (context, snapshot) {
          // 顯示載入動畫
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // 錯誤處理
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          // 取得資料後的顯示
          final data = snapshot.data!;
          print('auto login data:${data.toString()}'); 

        // 延遲到當前 Frame 結束後再更新狀態
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("addPostFrameCallback");
          context.read<LoginModel>().setProviderId(LoginType.autoLogin.path);
        });
           

          return 
          Center(child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              data['isLogin'] as bool ? Text('登入成功') : Text('登入失敗'),
              
              ElevatedButton(onPressed: (){
                    Navigator.pop(context);
              }, child:   Text("返回")),
              
            ],)
          );
        },
      ),
    );
  }

   
}