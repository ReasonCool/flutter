import 'package:flutter/material.dart'; 
// 自定义通知类型（用于传递字符串消息）
class CustomMessageNotification extends Notification {
  final String message;
  const CustomMessageNotification(this.message);
}
class ChildWidget extends StatelessWidget {
   ChildWidget({Key? key,required this.textString}): super(key:key);
  String textString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("訊息傳遞"),),
      body:   Center(
      child: Column(
        children: [
          Text("showText:$textString"),
          // 按钮1：派发文本消息
          ElevatedButton(
            onPressed: () {
              // 触发自定义通知
              const CustomMessageNotification("按钮1被点击").dispatch(context);
            },
            child: const Text('发送消息'),
          ),
          
          // 按钮2：派发坐标
          ElevatedButton(
            onPressed: () {
              // 触发带数据的通知
              CustomMessageNotification("sendMessionInfo").dispatch(context);
            },
            child: const Text('发送坐标'),
          ),
        ],
      ),
      )
    );
  }
}

class NotificationPage extends StatefulWidget{

  @override
  State<NotificationPage> createState()  => _NotificationPageState();

}
class _NotificationPageState extends State<NotificationPage>{ 
 

 // const NotificationPage ({Key? key}): super (key:key);

   String showText = "default";
  @override
  Widget build(BuildContext context){
     
    return  NotificationListener<CustomMessageNotification>(
            onNotification: (notification) {
              debugPrint("收到消息: ${notification.message}");
              
              print("parent ShowText:$showText");
              setState(() {
                showText = notification.message;
              });
              return true; // 阻止通知冒泡
            },
            child:   ChildWidget(textString: showText),
          );
   
               
  }
}