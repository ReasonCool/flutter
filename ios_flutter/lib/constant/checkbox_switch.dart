import "package:flutter/material.dart";
class CheckData {
   
      bool isDone  ;
      String title ; 
     
 CheckData ({required this.isDone, required this.title});
    }

    // 無狀態 Checkbox 組件
class TaskCheckItem extends StatelessWidget {
  final CheckData checkData;
 
  final VoidCallback onChanged;

  const TaskCheckItem({
    required this.checkData,
   
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checkData.isDone,
          onChanged: (_) => onChanged(), // 觸發父層狀態更新
        ),
        Text(checkData.title),
      ],
    );
  }
}


// 無狀態 Checkbox 組件
class TaskSwitchItem extends StatelessWidget {
  final CheckData checkData;
 
  final ValueChanged<bool> onChanged;

  const TaskSwitchItem({
    required this.checkData,
   
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: checkData.isDone,
          onChanged: (value) => onChanged(value), // 觸發父層狀態更新
        ),
        Text(checkData.title),
      ],
    );
  }
}
