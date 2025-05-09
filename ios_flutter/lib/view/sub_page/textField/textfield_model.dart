
import 'package:flutter/material.dart';
class TextFieldData{
  String text ;
  String labelText;
  String hintText;
  Widget prefixIcon;
  String errorText;
  TextInputType keyboardType;
  TextEditingController controller  = TextEditingController();
  bool obscureText ;
  bool verifyPass;
  FocusNode focusNode = FocusNode();
  String regexpSource;
  TextFieldData({required this.text,required this.labelText,required this.hintText,
  required this.prefixIcon,this.verifyPass = true ,this.regexpSource = '', this.errorText = "",this.keyboardType = TextInputType.text,this.obscureText = false});

  static List<TextFieldData> get TestData =>  [
      TextFieldData( text: "" , labelText: '用戶名', hintText: '用戶名', prefixIcon:Icon(Icons.person)  
          ,errorText: "請輸入至少3-6個字母",regexpSource: r'^[a-zA-Z0-9]{3,6}$'),
      TextFieldData( text: "" , labelText: '電子郵件', hintText: 'xxx@xxx.xxx', 
      prefixIcon:Icon(Icons.person)   ,errorText: "不符合格式",regexpSource:r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$' ),
      TextFieldData( text: "" , labelText: '行動電話', hintText: '09xx-xxx-xxx', prefixIcon:Icon(Icons.person)
       ,errorText: "不符合格式",regexpSource: r'^09\d{2}-?\d{3}-?\d{3}$'),
      TextFieldData( text: "" , labelText: '密碼', hintText: '英數六碼', prefixIcon:Icon(Icons.person)  
      ,errorText: "不符合格式",regexpSource: r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$'),

      ];
    

}


enum LoginDataType {
  userName('/UserName'),
  userEmail('/UserEmail'),
  userPhone('/UserPhone'),
  userPassWord('/UserPassWord');

final String loginType;
const LoginDataType(this.loginType);
}

typedef BuildContextCallback = void Function(BuildContext context);
checkSend(BuildContextCallback sendDataDo1,BuildContext context){
 //
  //嵌套詢問
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('確定要離開嗎？'),
      content: const Text('離開後未儲存的變更將會遺失'), // 建議加入說明文字
      actions: [
                TextButton(
                onPressed: () => Navigator.pop(context, false), // 明確關閉對話框並返回 false
                child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('提交'),
                ),
              ],
      ),
    ).then((value) {
      if (value ) {
        showDialog(
        context: context,
        barrierDismissible: false, // 禁止點擊外部關閉
        builder: (context) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('資料傳送中...'),
              ],
            ),
          ),
        );
        sendDataDo1(context);
      }
    });
  }
typedef TextFieldCallback = void Function(String text, int index);
  bool checkTextDatas(TextFieldCallback TextFieldOnChanged,List<TextFieldData> textDatas) {
      //確認驗證都通過 
      bool verifyPass = true;
      int index = 0;
      for (var item in textDatas) {
        TextFieldOnChanged(item.text, index);
        
        index++;
      }
      for (var item in textDatas) {
          
        if (item.verifyPass == false){
          verifyPass = false;
        }
        
      }
      return verifyPass;
    }

    Future sendDataDo(BuildContext context) async{
        try {
              // 執行實際傳送邏輯
              await Future.delayed(Duration(seconds: 2)); // 模擬傳送過程

              print('資料傳送完成');
            } catch (e) {
              print('傳送錯誤: $e');
            } finally {
              // 關閉等待畫面
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            } 
    }
  
