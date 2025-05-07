import 'package:flutter/material.dart';

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Row and Container'),backgroundColor: Colors.black12,),
      body: Center(
        
        child: Padding(padding: 
        const EdgeInsets.only(top: 2,left: 20,right: 20),
        child: Column(
          
      children: [
         Padding(padding: 
        const EdgeInsets.only(top: 2,left: 20),
        child: Container(
          color: Colors.red,
          height: 100,
        )

          
        ),
        
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 10,
                color: Colors.red,
                )
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 20,
                color: Colors.blue,
                )
            ),
          ],
        ),
        Padding(padding: 
        const EdgeInsets.only(top: 2)),
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 0,
              child: Container(
               
                width: 200,
                color: Colors.red,
                  child: Text("sdfsf"),
                )
            ),
            Padding(padding: 
        const EdgeInsets.only(left: 2)),
            Expanded(
              flex: 3,
              child: Container(
                height: 50,
                color: Colors.blue,
                )
            ),
            Padding(padding: 
        const EdgeInsets.only(left: 2)),
            Expanded(
              flex: 3,
              child: Container(
                height: 20,
                color: Colors.green,
                )
            ),
          ],
        )
      ]
        ) ,
          
        )
        

      )
    );
  }
}