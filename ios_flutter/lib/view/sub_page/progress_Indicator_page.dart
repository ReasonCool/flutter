import 'package:flutter/material.dart';
 
class ProgressIndicatorPage extends StatefulWidget{
  const ProgressIndicatorPage ({Key? key}): super (key:key);
  
  @override
  State<ProgressIndicatorPage> createState() => _ProgressIndicatorPageState();

}
class _ProgressIndicatorPageState extends State<ProgressIndicatorPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Progress Indicator"),),
      body:Center(child: Column(children: [
         SizedBox(
          height: 200,
          width: 300,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            //value: .7,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),

        ),
        SizedBox(
          height: 20,
          width: 20,),
        SizedBox(
          height: 50,
          width: 300,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
           //value: .9,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),

        )
     
       
      ])),
     
    );
  }
}