import 'package:flutter/material.dart';
import 'package:ios_flutter/interface/data_class.dart';
import 'package:ios_flutter/interface/typedef_funtion.dart';

 List<Widget>  createTextFormFields(List<TextFieldData> textDatas,
                                TextFieldCallback  TextFieldOnChanged,
                                IndexCallback TextFieldOnEditingComplete,
                                TextFieldCallback TextFieldOnSubmitted)
                                {
     
    List<Widget> textFormFieldList =  textDatas.asMap().entries.map((entry) {

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

       return TextFormField(
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
            validator: (inputValue) {
               
              if(inputValue is String ){
                bool isVerify = RegExp(textDatas[index].regexpSource).hasMatch(inputValue);
                return isVerify ? null : value.errorText; 
              }
              return value.errorText;

            },
            obscureText: value.obscureText,
            onEditingComplete: () {
              
                TextFieldOnEditingComplete(index);

                //focusScopeNode.requestFocus(textfield1Focus);
            },
            onFieldSubmitted: (value) {
               TextFieldOnSubmitted(value, index);
            },
          );
      }).toList();

      return textFormFieldList;
    }

