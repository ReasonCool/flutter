import 'package:flutter/material.dart';

// 继承 StatefulWidget 以管理可变状态
class CounterWrapper extends StatefulWidget {
  final Widget child;

  const CounterWrapper({super.key, required this.child});

  @override
  State<CounterWrapper> createState() => _CounterWrapperState();

  // // // 提供便捷方法获取状态（用于子组件访问数据）
  static _CounterWrapperState of(BuildContext context) {
    return context.findAncestorStateOfType<_CounterWrapperState>()!;
  }
}

class _CounterWrapperState extends State<CounterWrapper> {
  int _counter = 0; // 存储共享的计数器值

  // 修改数值的方法（触发重建）
  void increment() => setState(() => _counter++);
  void decrement() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
     print("CounterWrapperState build");
    // 将数据包裹在 InheritedWidget 中
    return _CounterInheritedWidget(
      counter: _counter,
      child: widget.child,
    );
  }
}

// 自定义 InheritedWidget
class _CounterInheritedWidget extends InheritedWidget {
  final int counter;

  const _CounterInheritedWidget({
    required this.counter,
    required super.child,
  });

  @override
  bool updateShouldNotify(_CounterInheritedWidget oldWidget) {
    // 当 counter 变化时，通知依赖的子组件
    return counter != oldWidget.counter;
  }

  // 提供静态方法获取数据
  static _CounterInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CounterInheritedWidget>()!;
  }
}


// 显示计数器的组件
class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    print("CounterDisplay build");
    // 获取共享的 counter 值（自动注册依赖）
    final counter = _CounterInheritedWidget.of(context).counter;
    return Text(
      '当前计数: $counter',
      style: const TextStyle(fontSize: 24),
    );
  }
}

// 操作按钮组件
class CounterButtons extends StatelessWidget {
  const CounterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    print("CounterButtons build");
    // 获取 CounterWrapper 的 State 对象以调用方法
    final state = CounterWrapper.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: state.decrement,
          child: const Text('-1'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: state.increment,
          child: const Text('+1'),
        ),
      ],
    );
  }
}



class ProviderPage extends StatefulWidget{
  const ProviderPage ({super.key});

  @override
  State<ProviderPage> createState() => _ProviderPageState() ;

  
}
class _ProviderPageState extends State<ProviderPage>{
  @override
  Widget build(BuildContext context){
    print("ProviderPage build");
    return CounterWrapper(
        child: Scaffold(
          appBar: AppBar(title: const Text('InheritedWidget 计数器')),
          body:  Center(
        child:Column(children: [
            CounterDisplay(),
                SizedBox(height: 20),
                CounterButtons(),
        ],) 
      ),
    )
    );
  }
}
 
 