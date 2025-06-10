import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/login_type_enum.dart';
import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/interface/email_typedef_funtion.dart';
import 'package:ios_flutter/model/email_login_model.dart';
import 'package:ios_flutter/future/firebase_login.dart';
import 'package:ios_flutter/enum/email_login_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';  //登入
import 'package:ios_flutter/model/loginInfo.dart';
import 'package:provider/provider.dart';

class EmailLoginPage extends StatefulWidget{
  const EmailLoginPage ({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPage();
}
class _EmailLoginPage extends State<EmailLoginPage>{

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
   EmailLoginState  resultState  = EmailLoginState.waitLogin;
  

  //修改登錄狀態並改變ＵＩ
  void modifyResult(EmailLoginState  resultValue ){ 

    setState(() {
     resultState = resultValue;
     //修改登入狀態

     
    });
  }

  

//登錄電子郵件與密碼畫面
Widget registFrom(VoidEmailLoginStateCallback modifyResult1){
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
      

      }
       
  TextFieldOnSubmitted (value,index) {
            print("TextFieldOnSubmitted value:$value index:$index");
             
 
      }

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
             
            //檢查輸入資料
            if(checkTextDatas(TextFieldOnChanged,textDatas) == false) return;
            
            loginEmailSend(sendEmailLoginInfo  ,context,textDatas,modifyResult1,'Email 與 密碼登入','是否登入');

          }
          
          , child: Text("登錄"))
        ],
      ),);

  }
  
   
//畫面生成
  @override
  Widget build(BuildContext context){ 

// 延遲到當前 Frame 結束後再更新狀態
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("addPostFrameCallback");
          if (resultState == EmailLoginState.success){
            context.read<LoginModel>().setProviderId(LoginType.emailPassword.path);
          }
          
        });
    
  
    return Scaffold(
      appBar: AppBar(title: Text("Email 登入"),),
      body: (resultState == EmailLoginState.waitLogin) ? registFrom(modifyResult) : resultState.buildWidgetByEmailLoginState(textDatas)
    );
  }
}