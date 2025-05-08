 
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class IconPage extends StatelessWidget {
  const IconPage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon Page'),
      
      ),
      body:Center(
        child: Column(children: [
          //第三方icon
           Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.pink,
                              size: 30.0,
                         ),
          //自帶icon
            Icon(Icons.accessible,color: Colors.green),
            Icon(Icons.error,color: Colors.green),
            Icon(Icons.fingerprint,color: Colors.green),    
                    

        ],)
      ),
    );
  }
}