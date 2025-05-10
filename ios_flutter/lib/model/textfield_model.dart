
import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/typedef_funtion.dart';
import 'package:ios_flutter/interface/data_class.dart';


enum LoginDataType {
  userName('/UserName'),
  userEmail('/UserEmail'),
  userPhone('/UserPhone'),
  userPassWord('/UserPassWord');

final String loginType;
const LoginDataType(this.loginType);
}



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
  


 List<Widget>  createTextFields(List<TextFieldData> textDatas,
                                TextFieldCallback  TextFieldOnChanged,
                                IndexCallback TextFieldOnEditingComplete,
                                TextFieldCallback TextFieldOnSubmitted)
                                {
     
    List<Widget> textFieldList =  textDatas.asMap().entries.map((entry) {

        final index = entry.key;
        final value = entry.value;
        final TextInputAction textInputAction;
        final bool autoFocus;

        if (index == textDatas.length - 1){
          textInputAction = TextInputAction.done;
          autoFocus = false;
        }else{
           textInputAction = TextInputAction.next;
           autoFocus = true;
        }

       return TextField(
            keyboardType: value.keyboardType,
            textInputAction: textInputAction,
            focusNode: value.focusNode,
            autofocus: autoFocus,
            onChanged: (value) {
              print("textfield1 value:$value");
              TextFieldOnChanged(value, index);

            },
            controller: value.controller,
            decoration: InputDecoration(
              labelText: value.labelText,
              hintText: value.hintText,
              prefixIcon: value.prefixIcon,
              errorText: value.verifyPass ? null : value.errorText,
      
            ),
            obscureText: value.obscureText,
            onEditingComplete: () {
              
                TextFieldOnEditingComplete(index);

                //focusScopeNode.requestFocus(textfield1Focus);
            },
            onSubmitted: (value) {
               TextFieldOnSubmitted(value, index);
            },
          );
      }).toList();

      return textFieldList;
    }


