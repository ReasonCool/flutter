import 'package:flutter/material.dart';
 
class AlignPage extends StatelessWidget{

  const AlignPage ({Key? key}): super (key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Align Page"),),
      body:Padding(padding:EdgeInsets.all(10),child:
        Center( child: Column(children: [
        Container(
          height: 300,
          width: 300,
          color: Colors.green,
          child: Align(
            alignment: FractionalOffset(0.9, 0.02),
            child: FlutterLogo(
              size: 60,
            ),
          )
          ,), 
       
      ]),
        )
      )
    );
  }
}