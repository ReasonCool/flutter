//
import 'package:flutter/material.dart';
class LayoutBuildPage extends StatelessWidget {
  const LayoutBuildPage({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [Text("a"),Text("a"),Text("a"),Text("a"),Text("a"),Text("a"),Text("a"),Text("a")];
    // 通过 LayoutBuilder 拿到父组件传递的约束，然后判断 maxWidth 是否小于200
    return Scaffold(
      appBar: AppBar(title: Text("sfdsfs"),),
      body:  LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          // 最大宽度小于200，显示单列
          return Column(children: children, mainAxisSize: MainAxisSize.min);
        } else {
          // 大于200，显示双列
          var _children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(Row(
                children: [children[i], children[i + 1]],
                mainAxisSize: MainAxisSize.min,
              ));
            } else {
              _children.add(children[i]);
            }
          }
          return Column(children: _children, mainAxisSize: MainAxisSize.min);
        }
      },
      )
    );
  }
}


// class LayoutBuilderRoute extends StatelessWidget {
//   const LayoutBuilderRoute({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var _children = List.filled(6, Text("A"));
//     // Column在本示例中在水平方向的最大宽度为屏幕的宽度
//     return Column(
//       children: [
//         // 限制宽度为190，小于 200
//         SizedBox(width: 190, child: ResponsiveColumn(children: _children)),
//         ResponsiveColumn(children: _children),
//         //LayoutLogPrint(child:Text("xx")) // 下面介绍
//       ],
//     );
//   }
// }
