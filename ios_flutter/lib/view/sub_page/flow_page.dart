import 'package:flutter/material.dart';
class FlowPage extends StatelessWidget{

  const FlowPage ({Key? key}): super (key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Wrap Page"),),
      body:   Flow(delegate: MyFlowDelegate(),children: [
        Container(width: 120,height: 20,color: Colors.green,child: Text("text"), ),  
      Container(width: 120,height: 20,color: Colors.blue ,child: Text("text"),
      ),  
]
)   
    );
  }
}




class MyFlowDelegate extends FlowDelegate{

  @override
  void paintChildren(FlowPaintingContext context){
    var x = 10.0;
    var y = 0.0;
    var z = 0.0;
    var gap = 10;
    for (int i = 0;i < context.childCount; i++){
        final childSize = context.getChildSize(i);
        if (childSize == null) continue;
        context.paintChild(i,transform: Matrix4.translationValues(x, y, z));
        x += gap + childSize.width;
        var contextWidth = context.size.width;
        var childWidth = childSize.width;
        print("context.size.width :$contextWidth  childSize.width:$childWidth");
        if (x > context.size.width - childSize.width){
          x = 10;
          y += childSize.height + gap + 10;
        } 
    }
  }
  @override
  Size getSize(BoxConstraints constraints){
    return Size(constraints.maxWidth,200);
  }

  @override
  bool shouldRepaint(MyFlowDelegate oldDelegate) => false ;

   
}