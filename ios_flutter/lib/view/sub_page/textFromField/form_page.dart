import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/model/email_regist_model.dart';
import 'package:ios_flutter/model/textFromField_model.dart';
class FormPage extends StatefulWidget{
  

  const FormPage ({super.key});
  @override
  State<FormPage> createState() => _FormPageState(); 
}
class _FormPageState extends State<FormPage>{

  final _formKey =  GlobalKey<FormState>();

  late List<TextFieldData> textDatas ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     textDatas = TextFieldData.TestData; 

  }

  @override
  Widget build(BuildContext context){

      TextFieldOnChanged(value,index){
       setState(() {
            bool isVerify = RegExp(textDatas[index].regexpSource).hasMatch(value);
            textDatas[index].text = value;
            print("TextFieldOnChanged990 value:$value index:$index isVerify:$isVerify");
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

      List<Widget> textFieldList = createTextFormFields(textDatas, TextFieldOnChanged, TextFieldOnEditingComplete, TextFieldOnSubmitted);

    return Scaffold(
      appBar: AppBar(title: Text("Form Page"),),
      body:Form(key:_formKey,child: Column(children: [
        ...textFieldList,ElevatedButton(onPressed: (){
            //檢查
            if((_formKey.currentState as FormState).validate()){
              checkSend(sendDataDo,context);
            }
            

          }
          , child: Text("驗證並儲存"))
      ],),) ,
    );
  }
}