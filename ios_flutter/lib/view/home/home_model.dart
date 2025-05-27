
import 'package:flutter/material.dart';
import 'package:ios_flutter/enum/app_context.dart';




//子功能：建立按鈕與開啟頁面功能
Widget _buildElevateButton(BuildContext context,MapEntry<String,Map<String,String>> entry){
     final String routePath = entry.key;
     final Map<String,String> buttonText = entry.value;
     final String titleStr;
     if (buttonText['title'] is String) {
        titleStr = buttonText['title']!;
     }else{
        titleStr = "not title";
     };

     final String? argStr = buttonText['arg'];
    final bool isAwait;
    if (buttonText['wait'] is Object) {
      isAwait = true;
    }else{
      isAwait = false;
    }


    void pressedNotResult(){
        Navigator.pushNamed(context, routePath, arguments: argStr); 
    };
    void pressedResult() async{
      var result = await Navigator.pushNamed(context, routePath, arguments: argStr); 
      print("pressedResult: $result");
    };
    

    return Container(
      // width: 10,
      // height: 50,
      child:ElevatedButton(
         style: ElevatedButton.styleFrom(
        padding:  const EdgeInsets.all(5) ,
        backgroundColor: Colors.blue, // 浅色背景
        foregroundColor: Colors.black, // 深色文字
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blue.shade100, width: 1),
        ),
      ),
        onPressed: isAwait ? pressedResult : pressedNotResult , child: Text(titleStr)
    ) ,
    ); 
  } 

//子功能：建立Grid Layout
Widget _buildGridLayout(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight= MediaQuery.of(context).size.height;
    print("screenWidth:$screenWidth");
    print("screenHeight:$screenHeight");
    final crossAxisCount = screenWidth > 300 ? 3 : 2; // 自适应列数

    return Padding(padding: EdgeInsets.all(12),
    child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // 动态列数
        mainAxisSpacing: 10,    // 垂直间距
        crossAxisSpacing: 10,   // 水平间距
        childAspectRatio: 2.5,  // 宽高比例
      ), 
      itemCount: AppRoutes.rountNames.length,
      itemBuilder: (context,index){
        final entry = AppRoutes.rountNames.entries.elementAt(index);
        return _buildElevateButton(context, entry);
      }), );
    }

//子功能：建立底圖  
Widget _buildBackground(){
    return Positioned.fill(child:  Image(
                image: AssetImage("resource/images/cat.png"),
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.2),
              ),);
  }

//子功能：建立主畫面
Widget buildAddBgImage(BuildContext context){
    return Stack(
      children: [
        _buildBackground(),
        _buildGridLayout(context)
      ],
    );
  }


//class PopupMenuButton<T> extends StatefulWidget {


createDialog(BuildContext context){
   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('操作確認'),
        content: Text('確定要執行此操作嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              print('已確認操作');
              Navigator.pop(context);
            },
            child: Text('確定'),
          ),
        ],
      ),
    );
}