import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 class ProviderSdkPage extends StatelessWidget {
  const ProviderSdkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // 正确使用 MultiProvider
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        // 添加其他 Provider...
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Provider 示例')),
        body: const ProviderCounterPage(),
    ), 
    );
  }
}

// 定义 Model
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    //强制要求：数据修改后必须调用 notifyListeners()
    notifyListeners();
  }
}

// 子页面
class ProviderCounterPage extends StatelessWidget {
  const ProviderCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("provider sdk page build");
    return Center(
      child:Column(children: [
      
     
      ElevatedButton(onPressed: () =>
        context.read<CounterModel>().increment()
       , child: Text("修改數值")) ,
// 方法 2：通过 Consumer 触发
          Consumer<CounterModel>(
            builder: (context, model, _) {
              return ElevatedButton(
                onPressed: model.increment,
                child: const Text('Consumer 触发'),
              );
            },
          ),

 Consumer<CounterModel>(
            builder: (context, model, _) {
              return  Text(
        '计数: ${context.watch<CounterModel>().count}',
        style: const TextStyle(fontSize: 24),
      );
            },
          ),

 Text(
        """
使用provider 第三方元件 可監聽數值直接重繪StatelessWidget的畫面
""",
        style: const TextStyle(fontSize: 24),
      ),
      ],)
    );
  }
}

   