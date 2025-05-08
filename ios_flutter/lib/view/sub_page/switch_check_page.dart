//
//
// 接收外部資料 checkValueTag switchValueTag
//
/**
 * 不同場景下的回調處理方案
需求場景	回調定義方式	使用範例
只需知道點擊事件	VoidCallback	onChanged: () => ...
需要知道新值	ValueChanged<bool>	onChanged: (value) => ...

 */
import "package:flutter/material.dart";
import 'package:ios_flutter/constant/checkbox_switch.dart'; 



class SwitchCheckPage extends StatefulWidget{
   

 final List<CheckData>? switchValueTags ;

  final List<CheckData>? checkValueTags ;
  
   SwitchCheckPage ({Key? key,this.checkValueTags ,this.switchValueTags }): super (key:key);

  @override
  State<SwitchCheckPage> createState() => _SwitchCheckPageState();
}
class _SwitchCheckPageState extends State<SwitchCheckPage>{

 
  late List<CheckData> checkValue ;
  late List<CheckData> switchValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = widget.switchValueTags ?? [CheckData( isDone:  true, title: '窗戶'),CheckData(isDone: false, title: '電燈')];
    checkValue = widget.checkValueTags ?? [CheckData(isDone: false,title:  '檢查窗戶'),CheckData(isDone:false ,title:  '檢查電燈')];
  }


@override
  Widget build(BuildContext context){

    print("build");

    onSwitchChangeed(index,newValue){
      setState(() {
        switchValue[index].isDone = newValue;
      });
    }
    onCheckBoxChangeed(int index){
      setState(() {
      checkValue[index].isDone = !checkValue[index].isDone;
      });
    }

    String markStr = """
      .支援傳入switch 和 checkbox 的資料
      .StatefulWidget:使用list <CheckData>  switch 和 checkbox  
      .StatelessWidget :  switch 與 checkbox UI
      
    """;
    return Scaffold(
      appBar: AppBar(title: Text("Switch and Checkbox"),),
      body:Center(child: Column(children: [ Text(markStr),Text("Switch "),
        ...switchValue.asMap().entries.map((entry){
          final index = entry.key;
          final task = entry.value;
          return TaskSwitchItem(checkData: task, onChanged:(newValue) => onSwitchChangeed(index ,newValue));
           
        }).toList(),
        Text("CheckBox"),
        
        ...checkValue.asMap().entries.map((entry){
          final index = entry.key;
          final task = entry.value;
          return TaskCheckItem(checkData: task, onChanged:() => onCheckBoxChangeed(index ));
           
        }).toList(),
       

      ],
      ),
      ),
    );
  }
}


  