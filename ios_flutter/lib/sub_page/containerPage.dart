import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Row and Container'),backgroundColor: Colors.black12,),
      body: Center(
        
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
           
          //  mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              decoration:BoxDecoration(
                border: Border.all(width: 10,color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(8)),

              ),
              margin: const EdgeInsets.all(4),
              child: Image(
                image: AssetImage("resource/images/cat.png"),
                width:280,
                height:280,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,//佔用的尺寸
              mainAxisAlignment: MainAxisAlignment.center,//水平組件對齊方向
              textDirection: TextDirection.rtl,//表示水平方向的佈局順序
              
            children: [
              Container(
              decoration:BoxDecoration(
                border: Border.all(width: 10,color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                

              ),
              margin: const EdgeInsets.all(4),
              child: Image(
                image: AssetImage("resource/images/cat.png"),
                width:30,
                height:30,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
             
            Container(
              margin: const EdgeInsets.all(20.0),
              color:Colors.orange,
              child: const Text("Hello Txt"),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              color:Colors.orange,
              child: const Text("container Txt"),
            ),
          ],
            
          ),
          
         Container(
              decoration:BoxDecoration(
                border: Border.all(width: 3,color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(8))
                ),
              margin: const EdgeInsets.all(20.0),
               
              // color:Colors.orange,
               height: 150,
               width: 400,
               
              child: const Text("""sdfsfsfsfsafsajflkwefnewk
              123lefcnslkfsfssdfs
              sdfsfdsfdsfdsf
              sdfsfdsdfsfs   sdfsfs
              dfsfdsxt
              """,
              textAlign: TextAlign.left,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
                style: TextStyle( 
                color:Colors.green,
                  fontSize: 20,
                  height: 1.5,
                backgroundColor: Colors.yellow,
                decoration: TextDecoration.underline,
                ),),
            ),
             ],
      ),
    ),
      backgroundColor: Colors.lightGreen,

    );
  }
}