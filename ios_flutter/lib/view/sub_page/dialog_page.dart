import 'package:flutter/material.dart';

class DialogPage extends StatelessWidget{

  const DialogPage ({super.key});

  @override
  Widget build(BuildContext context){

void showAlertDialog(BuildContext context) {
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('撥打電話'),
              onTap: () {
                print('撥打電話中...');
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('發送郵件'),
              onTap: () {
                print('郵件已發送');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }




    return Scaffold(
      appBar: AppBar(title: Text("Dialog 對話匡"),),
      body:Center(child:  Column(children: [
        ElevatedButton(onPressed: () {
          showAlertDialog(context);
        }
        , child: 
        Text("彈出對話匡")),
        ElevatedButton(onPressed: () {
          showBottomSheet(context);
        }
        , child: 
        Text("彈出底部彈窗")),
      ],)
      )
    );
    
  }
  
}
