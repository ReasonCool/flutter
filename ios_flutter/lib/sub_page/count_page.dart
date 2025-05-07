import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build (BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: (){
        /*
        // 查找父的 _CounterState
         final counterState = context.findAncestorStateOfType<_CounterPageState>();
       // 安全調用重置方法
        counterState?.resetCounter();
        if (counterState == null){
          debugPrint('Error Ancestor _CounterState!');
        }
        */
       CounterPage.of(context).resetCounter();
        
    }
    , child: Text("重置參數")
  
    );

  }
}


class CounterPage extends StatefulWidget {
  const CounterPage({super.key, this.initValue = 0});
 final int initValue;

 // 自定義 .of() 方法
  static _CounterPageState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_CounterPageState>();
    if (state == null) {
      throw FlutterError('CounterPage.of() 未找到! 請確保在 CounterPage 的子樹中使用。');
    }
    return state;
  }


  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

   @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState");
  }

// 子 Widget 需要調用的方法
  void resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter+=2;
      print("setState");
    });
  }
  
   

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('按鈕計數'),
        centerTitle: true,
        
      ),
      body:SafeArea(child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.pink,
                              size: 30.0,
                         ),
                          const Text(
                            'You have pushed the button this many times:',
                          ),
                          Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 50 ),
                          ElevatedButton(
                            onPressed: _incrementCounter,
                            child: const Text('Increment Counter'),
                          ),
                          const SizedBox(height: 20),
                          const ResetButton(),
                        ],
                      ),
                    ), ) 
    ,
     floatingActionButton: FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ), );
  }

  

  @override
  void didUpdateWidget(CounterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget ");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
