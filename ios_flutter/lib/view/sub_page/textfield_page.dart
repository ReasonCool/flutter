
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

 
}


enum LoginDataType {
  userName('/UserName'),
  userEmail('/UserEmail'),
  userPhone('/UserPhone'),
  userPassWord('/UserPassWord');

final String loginType;
const LoginDataType(this.loginType);



}

class TextFieldPage extends StatefulWidget{
  const TextFieldPage ({Key? key}) : super(key:key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}
class _TextFieldPageState extends State<TextFieldPage>{

 
  late List<TextFieldData> textDatas ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     textDatas = [
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

  @override
  Widget build(BuildContext context){

    print("build");

     

      TextFieldOnChanged(value,index){
        setState(() {
            bool isVerify = RegExp(textDatas[index].regexpSource).hasMatch(value);
            textDatas[index].text = value;
            print("TextFieldOnSubmitted value:$value index:$index isVerify:$isVerify");
            textDatas[index].verifyPass = isVerify;
          
           
        });
      }

      TextFieldOnEditingComplete(int index) {
        print("TextFieldOnEditingComplete");
        int indexTag = index + 1  ;
        if(indexTag < textDatas.length  ){
           FocusScope.of(context).requestFocus(textDatas[indexTag].focusNode);
        }
      

      };
       
      TextFieldOnSubmitted (value,index) {
            print("TextFieldOnSubmitted value:$value index:$index");
            // 在提交按钮中增加更复杂的验证逻辑
 
      };
     
      List<Widget> textFields = textDatas.asMap().entries.map((entry) {

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

    

    Future<bool> askSendData() async {
      final bool? confirmExit = await showDialog<bool>(
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
              onPressed: () => Navigator.pop(context, true), // 明確關閉對話框並返回 true
              child: const Text('確定'),
            ),
          ],
        ),
      );

      return confirmExit ?? false; // 處理 null 情況 (用戶直接點擊對話框外關閉)
    }

    bool checkTextDatas() {
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
    // 在全局或工具類別中定義加載對話框
    void showLoadingDialog(BuildContext context) {
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
    }
    return Scaffold(
      appBar: AppBar(title: Text("TextField"),),
      body: Center(child:Column(
        children: <Widget>[
          ...textFields
         ,
          ElevatedButton(onPressed: 
          () async {
             
            
             //顯示送出對話
            if( checkTextDatas() == false){
              return; 
           
            }
            // 顯示確認對話框並等待結果

            bool isSend =  await askSendData();
            if(isSend == false){
                return;
            }
            //顯示等待畫面
            // 顯示等待畫面
              showLoadingDialog(context);
             //儲存資料到本地
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
          }, child: Text("儲存"))
        ],
      ),),
    );
  }
}