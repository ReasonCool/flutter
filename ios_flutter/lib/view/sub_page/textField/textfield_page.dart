
import 'package:flutter/material.dart';

import 'package:ios_flutter/view/sub_page/textField/textfield_model.dart';

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
          , child: Text("儲存"))
        ],
      ),),
    );
  }
}