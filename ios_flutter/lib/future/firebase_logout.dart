import 'package:ios_flutter/model/loginInfo.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


showLogout(BuildContext context) async{
  bool? delete = await askLogout(context);
    if (delete == null) {
      print("取消");
    } else {
      print("已确认删除");
       context.read<LoginModel>().setProviderId(null);
    }
}

//await FirebaseAuth.instance.signOut();
Future<bool?> askLogout(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("再次確認"),
        content: Text("要登出嗎"),
        actions: <Widget>[
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          TextButton(
            child: Text("登出"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}