 

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

//test class to json string  and json string to class 
//step 1 : create class 
//step 2 : create auto create decode and incode json file


class LocalDataPage extends StatefulWidget{

  const LocalDataPage ({Key? key}):super (key:key);

  @override
  State<LocalDataPage> createState() => _LocalDataPage();

}
class _LocalDataPage extends State<LocalDataPage>{

 

  String userInfo = """{'Name':'John','Age':15}""";
  
  String localKey = 'User Info';

  String locatState = '等待取本地資料'; 
   

   void changeUI(String localInfo ){
    setState(()   {
       locatState =  localInfo;  
      
    });
   }

  setLocalInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSavaSuccess  = await prefs.setString(localKey, userInfo);
    changeUI(' isSavaSuccess :$isSavaSuccess ');

  }
  getLocalInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userInfo =     prefs.getString(localKey);
    changeUI(' userInfo :$userInfo');

  }

  removeLocalInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     bool isRemoveSuccess =   await prefs.remove(localKey) ;
    changeUI('isRemoveSuccess :$isRemoveSuccess');

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Local Data Page'),),
      body: Center(child: Column(children: [
          Text('操作的字串：$userInfo'),
          Text(locatState),
          ElevatedButton(onPressed: (){
            //儲存資料
            setLocalInfo();

          }, child:  Text('儲存本地資料 ')),
          ElevatedButton(onPressed: (){
            //儲存資料
            getLocalInfo();

          }, child:  Text('取得本地資料')),
           ElevatedButton(onPressed: (){
            //儲存資料
            removeLocalInfo();

          }, child:  Text('清除本地資料')),
      ],),),
    );
  }
}