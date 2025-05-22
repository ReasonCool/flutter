import 'package:flutter/material.dart';
 

// 定义 login Model
class LoginModel extends ChangeNotifier {
//singleton 單例
// static final LoginModel _loginModel = LoginModel._internal();
  
//   factory LoginModel() {
//     return _loginModel;
//   }
  
//   LoginModel._internal();



  //是否已登入
  bool _isLogin = false;
  String? _providerId;

  
void setProviderId(String? providerId) {
if (providerId != null){
      _isLogin = true;
      _providerId = providerId;

    }else{
       _isLogin = false;
       _providerId = null;
    }
    notifyListeners();
  }

    bool get isLogin => _isLogin;
    String? get providerId => _providerId;

   
}