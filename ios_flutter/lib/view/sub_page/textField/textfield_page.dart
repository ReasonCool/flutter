
import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/login_data_class.dart';
import 'package:ios_flutter/model/textfield_model.dart';

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
     textDatas = TextFieldData.TestData; 

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
             
 
      };

     List<Widget>  textFields = createTextFields(textDatas,
                                                  TextFieldOnChanged,
                                                  TextFieldOnEditingComplete,
                                                  TextFieldOnSubmitted);

  
    return Scaffold(
      appBar: AppBar(title: Text("TextField"),),
      body: Center(child:Column(
        children: <Widget>[
          ...textFields
         ,
          ElevatedButton(onPressed: (){
            //檢查

            if(checkTextDatas(TextFieldOnChanged,textDatas) == false) return;
            
            checkSend(sendDataDo,context);

          }
          , child: Text("驗證並儲存"))
        ],
      ),),
    );
  }
}