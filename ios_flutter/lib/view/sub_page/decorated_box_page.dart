import 'package:flutter/material.dart';
 
class DecoratedBoxPage extends StatelessWidget{

  const DecoratedBoxPage ({Key? key}): super (key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("DecoratedBox Page"),),
      body:Column(
          children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.yellow],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                            spreadRadius: 1,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      position: DecorationPosition.background,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {

                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Text('PRESS ME', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
            ),
           DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
               // widthFactor: 1,
                heightFactor: 10,
                child:Text("") ,
              ),
           ),
         
          DecoratedBox(
             decoration: BoxDecoration(
              color: const Color.fromRGBO(99, 102, 169, 1),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(width: 1, color: Colors.blue),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow,
                  blurRadius: 8,
                  offset: Offset(21, 21),
                ),
              ],
            ),
                child:Padding(padding: EdgeInsets.all(10),child:Column(children: [
                Text("ABC"),Text("ABC"),
                ] ) ,
              ),
          ),
          ]
      ),
       
     
    );
  }
}