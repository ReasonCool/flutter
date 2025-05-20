import 'package:flutter/material.dart';
class WrapPage extends StatelessWidget{

  const WrapPage ({Key? key}): super (key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Wrap Page"),),
      body: Center(heightFactor: 1, child:  Wrap( 
        alignment:WrapAlignment.center ,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,

        spacing: 8.0, // Horizontal space between children
        runSpacing: 4.0, // Vertical space between lines
        children:  ['Flutter', 'Dart', 'Widgets', 'Layout', 'Animation', 'State Management'
        ].map((String text) {
          return Chip(
            label: Text(text),
            backgroundColor: Colors.blue,
          );
        }).toList(),      
        ),) 
    );
  }
}