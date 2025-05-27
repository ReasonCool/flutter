 

import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/interface/typedef_funtion.dart';
import 'package:ios_flutter/model/email_regist_model.dart';
import 'package:ios_flutter/future/firebase_register.dart';
import 'package:ios_flutter/enum/email_regist_enum.dart';
 import 'package:firebase_auth/firebase_auth.dart';  //登入
 
class EmailRegistPage extends StatefulWidget{
  const EmailRegistPage ({Key? key}): super (key:key);

@override
  State<EmailRegistPage> createState() => _EmailRegistPageState();
}
class _EmailRegistPageState extends State<EmailRegistPage>{
//輸入資料匡設定資料
 late List<TextFieldData> textDatas ;
 

//初始化狀態
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     textDatas = TextFieldData.EmailRegistTextFields;

  } 

  //確認登錄的狀態
   EmailRegistState  resultState  = EmailRegistState.waitRegist;
  

  //修改登錄狀態並改變ＵＩ
  void modifyResult(EmailRegistState  resultValue ){ 

    setState(() {
     resultState = resultValue;
     
    });
  }

  

//登錄電子郵件與密碼畫面
Widget registFrom(VoidEmailRegistStateCallback modifyResult1){
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
             
 
      };

     List<Widget>  textFields = createTextFields(textDatas,
                                                  TextFieldOnChanged,
                                                  TextFieldOnEditingComplete,
                                                  TextFieldOnSubmitted);
  return Center(   child:Column(
        children: <Widget>[
          ...textFields
         ,

          ElevatedButton(onPressed: (){
            //檢查
             

            if(checkTextDatas(TextFieldOnChanged,textDatas) == false) return;
            
            checkEmailSend(sendEmailRegistInfo  ,context,textDatas,modifyResult1,'Email 登錄','是否登錄');

          }
          
          , child: Text("登錄"))
        ],
      ),);

  }
  
   
//畫面生成
  @override
  Widget build(BuildContext context){ 
  
    return Scaffold(
      appBar: AppBar(title: Text("Email 登錄"),),
      body: (resultState == EmailRegistState.waitRegist) ? registFrom(modifyResult) : resultState.buildWidgetByEmailRegistState(textDatas)
    );
  }
}