import 'package:flutter/material.dart';
 
class InheritedWidgetPage extends StatefulWidget{
 const InheritedWidgetPage ({Key? key}): super(key:key);


  @override
  State<InheritedWidgetPage> createState() => _InheritedWidgetPageState();
}
class _InheritedWidgetPageState extends State<InheritedWidgetPage>{
  var inheritedWidget = 0;


  @override
  Widget build(BuildContext context){
   
    print('build');

    return Scaffold(
      appBar: AppBar(title: TextButton(onPressed: (){

      }, child: Text("get InheritedValue"))
      ),
      body: Column(children: [  ElevatedButton(onPressed: (){

        setState(() {
       print("inheritedWidget = $inheritedWidget");
          inheritedWidget = inheritedWidget + 1;
      });
         
        
        //print("button:inheritedWidget: $inheritedWidget");
         
      }, child:Text("點擊次數：$inheritedWidget")),ShareDataWidget(count:inheritedWidget, child:_TestWidget() ) ],) 
    );
  }

   

}
class ShareDataWidget extends InheritedWidget{
  ShareDataWidget({
    Key? key,
    required this.count,
    required Widget child,

  }) : super(key:key ,child:child);


  final int count;

  static ShareDataWidget? of(BuildContext context){
    print(' ShareDataWidget ? of(BuildContext context)');
    var resultData = context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    return resultData;
  //  var element = context.getElementForInheritedWidgetOfExactType();
  //  if (element != null) {
  //   print(' ShareDataWidget element.widget as ShareDataWidget success)');
  //   return  element.widget as ShareDataWidget;
  //  }else{
  //   print(' ShareDataWidget element.widget as ShareDataWidget null)');
  //   return null;
  //  }
    
  }


  //回傳true會觸發 child （statefulWidget）的 void didChangeDependencies()事件
  @override
  bool updateShouldNotify(ShareDataWidget old){
    var oldCount = old.count;
    print('updateShouldNotify old.count:$oldCount  count:$count  ');
    if(oldCount < 5){
      return false;
    
    }
    
    return old.count != count;
  }
}






class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {

 

  @override
  Widget build(BuildContext context) {
    var checkDate = DateTime.now();
    var shareData = ShareDataWidget.of(context);
    String textValue ;
    if (shareData != null){
      textValue = shareData.count.toString();
    }else{
      textValue = "share data is null";
    }
    //使用InheritedWidget中的共享数据
    return Row(children: [
      Text('checkDate:$checkDate  :'), Text(textValue),
    ]
    );
  }

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}