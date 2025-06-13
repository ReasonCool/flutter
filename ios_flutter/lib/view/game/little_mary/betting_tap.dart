import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ColoredTapTextSprite extends PositionComponent with TapCallbacks {
  Color backgroundColor;
  int _counter;
  final TextStyle textStyle;
  final Vector2 colorSize;
  final String itemId;

  final bool Function(int newValue,String itemId)? onCounterChanged;
  
  late TextComponent textComponent;
  
  // 移除 EffectController 成员变量
  ColoredTapTextSprite({
    required this.itemId,
    required this.backgroundColor,
    int initialValue = 0,

    required this.colorSize,
    this.textStyle = const TextStyle(
      color: Color.fromARGB(255, 232, 228, 228),
      fontSize: 60,
      fontWeight: FontWeight.bold,
    ),
    Vector2? position,
    this.onCounterChanged,
  })  : _counter = initialValue,
        super(
          position: position ?? Vector2.zero(),
          size: colorSize,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 添加背景矩形
    add(RectangleComponent(
      size: size,
      paint: BasicPalette.transparent.paint()..color = backgroundColor,
    ));

    // 添加文字组件
    textComponent = TextComponent(
      text: _counter.toString(),
      textRenderer: TextPaint(style: textStyle),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(textComponent);

    // 添加脉冲光晕效果
    add(_createPulseEffect());
  }

  // 创建脉冲光晕效果
  CircleComponent _createPulseEffect() {
    return CircleComponent(
      radius: size.x / 2 * 1.2,
      anchor: Anchor.center,
      position: size / 2,
      paint: Paint()
        ..color = backgroundColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    )
      ..add(
        SequenceEffect([
          ScaleEffect.to(
            Vector2(1.2, 1.2),
            EffectController(
              duration: 1.0,
              reverseDuration: 1.0,
              infinite: true,
              curve: Curves.easeInOut,
            ),
          ),
          OpacityEffect.to(
            0.1,
            EffectController(
              duration: 1.0,
              reverseDuration: 1.0,
              infinite: true,
              curve: Curves.easeInOut,
            ),
          ),
        ]),
      );
  }

  @override
  void onTapDown(TapDownEvent event) {

    if(_counter >= 20){
      return;
    }
     // 通知监听器
    if (onCounterChanged != null) {
      if (onCounterChanged!(_counter,itemId) == false){
        return;
      };
    }
    // 增加计数器
    _counter++;
    textComponent.text = _counter.toString();

    

   

    // 标记事件已处理
    event.handled = true;
  }

  

  // 获取当前计数器值
  int get counter => _counter;

  // 设置计数器值
  set counter(int value) {
    _counter = value;
    if (isLoaded) {
      textComponent.text = value.toString();
    }
  }

  // 重置计数器
  void resetCounter() {
    counter = 0;
  }
  
  // 可选：覆盖此方法以实现圆形点击区域
  @override
  bool containsLocalPoint(Vector2 point) {
    // 计算点到中心的距离
    final center = size / 2;
    final distance = (point - center).length;
    
    // 如果距离小于半径，则点在圆形内
    return distance <= size.x / 2;
  }
}