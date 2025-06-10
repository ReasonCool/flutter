 import 'package:flutter/material.dart';

class NavigatorTransforDataSateful extends StatefulWidget{
  const NavigatorTransforDataSateful ({super.key});

  @override
  State<NavigatorTransforDataSateful> createState() {
    return _NavigatorTransforDataSatefulState();
  }  

}
class _NavigatorTransforDataSatefulState extends State<NavigatorTransforDataSateful>{

   String? _naviTransforArgs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //在禎回調後安全獲取
    WidgetsBinding.instance.addPostFrameCallback((_){
      final args = ModalRoute.of(context)?.settings.arguments;
      if(args is String){
        setState(() {
          _naviTransforArgs = args;
          print("get navigator transfor arges stateful : $_naviTransforArgs");
        });
        
      }

    });
   

  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(title: const Text('StatelessWidget'),backgroundColor: Colors.black12,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {  // 添加 async 關鍵字
            // 顯示確認對話框並等待結果
            final bool? confirmExit = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('確定要離開嗎？'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false), // 取消返回
                    child: const Text('取消'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), // 確認返回
                    child: const Text('確定'),
                  ),
                ],
              ),
            );

            // 只有當用戶點擊確定時才執行返回
            if (confirmExit == true) {
              //if (mounted) {  // 確保 widget 仍存在於樹中 statefulwidget
                 Navigator.pop(context,"callback statefulStr"); // 執行頁面返回
              //}
            }
          }
      ), 
          
      ),
       
      body:  Center(
        child: Column(
          children: [
            Text("args : $_naviTransforArgs"),
            
          ],
        ),
     )
     );


  }

}