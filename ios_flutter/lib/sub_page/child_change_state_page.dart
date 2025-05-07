import 'package:flutter/material.dart';
// ParentWidget 为 TapboxB 管理状态.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
 const ParentWidget({super.key});
 

  @override
   State<ParentWidget>  createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active2 = false;
  bool _active3= false;



  void _handleTapbox2Changed() {
    setState(() {
      _active2 = !_active2;
      
    });
  }
  void _handleTapbox3Changed() {
    setState(() {
      _active3 = !_active3;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build ");
    return Scaffold(
       appBar: AppBar(title: const Text('child change state page'),backgroundColor: Colors.black12,
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
              if (mounted) {  // 確保 widget 仍存在於樹中
                Navigator.pop(context,"callbackStr"); // 執行頁面返回
              }
            }
          }
      ),
       
       ),
      body: Center(
      child: Column(children: [
        Text("parent value : $_active3"),
        
        Text("Child Tap Box B "),
        TapboxB(
          active: _active3,
          onChanged: _handleTapbox2Changed,
        ),
        Text("parent value : $_active2"),
        Text("Child Tap Box C "),
        TapboxB(
          active: _active2,
          onChanged: _handleTapbox3Changed,
        ),
      ],) 
      )
    );
  }
}
     

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatefulWidget {
  TapboxB({Key? key, this.active = false, required this.onChanged})
      : super(key: key);


      final bool active;
     
  // final ValueChanged<bool> onChanged;
   final Function  onChanged;

  
  @override
  State<TapboxB> createState() => _TapboxB();
}


class _TapboxB extends State<TapboxB>{  


void _handleTap() {
     //onChanged(!active);
    widget.onChanged();
  }

   bool _textTag = false;

void _handleButtonText() {
     setState(() {
       _textTag = !_textTag;
     });
    
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
         width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
        child: Center(
          child: Column(children: [
            ElevatedButton(onPressed: _handleButtonText
             , child: Text("Change Button Text")),
            Text(
              _textTag ? 'Button Text Active' : 'Button Text Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white),
            ),
            
          ],) 
        ),
      ),
    );
  }
}



 