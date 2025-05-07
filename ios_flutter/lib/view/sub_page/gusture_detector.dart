import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget{
  TapboxA({Key? key}) : super (key: key);
  
  @override
  State<TapboxA> createState() => _TapboxAState();
    
}

class _TapboxAState extends State<TapboxA>{
  bool _active = false;
  void _handleTap(){
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
        backgroundColor: Colors.black12,
      ),
      body: GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 200,
        width: 200,
  
        decoration: BoxDecoration(
          color: _active ? Colors.lightBlue : Colors.lightGreen,
        ),
        child: Center(
          child: Text(
            _active ? "True" : "False",
            style: TextStyle(fontSize: 32.0,color: Colors.white),
            ),
        ),
      ) 
    )
    );
  }
}