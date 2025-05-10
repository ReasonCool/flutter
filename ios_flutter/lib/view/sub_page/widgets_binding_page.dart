import 'package:flutter/material.dart';

class WidgetsBindingPage extends StatefulWidget {
  const WidgetsBindingPage({super.key});

  @override
  State<WidgetsBindingPage> createState() => _WidgetsBindingPageState();
}

class _WidgetsBindingPageState extends State<WidgetsBindingPage> {
  final GlobalKey _titleKey = GlobalKey();
  Size? _titleSize;

  @override
  void initState() {
    super.initState();
    // 注册布局完成监听
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTitleSize();
    });
  }

  void _getTitleSize() {
    final renderBox = _titleKey.currentContext?.findRenderObject() as RenderBox?;
    setState(() {
      _titleSize = renderBox?.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('After Layout Demo')),
      body: Column(
        children: [
          Container(
            key: _titleKey,
            padding: const EdgeInsets.all(20),
            child: const Text('需要测量尺寸的标题'),
          ),
          if (_titleSize != null)
            Text('测量结果：宽 ${_titleSize!.width}px 高 ${_titleSize!.height}px'),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  color: Colors.blue.withOpacity(0.2),
                  alignment: Alignment.center,
                  child: Text('剩余高度：${constraints.maxHeight}px'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
