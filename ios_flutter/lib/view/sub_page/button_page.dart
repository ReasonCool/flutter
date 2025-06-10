import 'package:flutter/material.dart';
class ButtonPage extends StatelessWidget{
  const ButtonPage ({super.key});
  @override
  Widget build(BuildContext context){

    onPressed(){
      print("button pressed");
    }

    return Scaffold(
     appBar: AppBar(title: Text("Button Page"),),
     body: Center(
      child: Column(children: [
        ElevatedButton(
          child: Text("ElevatedButton"),
          onPressed: () {},
        ),
        TextButton(
          child: Text("TextButton"),
          onPressed: () {},
        ),
        OutlinedButton(
          child: Text("OutlinedButton"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () {},
        ),ElevatedButton.icon(
          icon: Icon(Icons.send),
          label: Text("ElevatedButton.icon"),
          onPressed: onPressed,
        ),
        OutlinedButton.icon(
          icon: Icon(Icons.add),
          label: Text("OutlinedButton.icon"),
          onPressed: onPressed,
        ),
        TextButton.icon(
          icon: Icon(Icons.info),
          label: Text("TextButton.icon"),
          onPressed: onPressed,
        ),

      ],),
     ),
    );
  }
}