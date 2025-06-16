import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/events.dart';


class HudCustomButton extends PositionComponent with TapCallbacks {
  final void Function() onPressed;
  final String titleStr;
  HudCustomButton({
    required this.onPressed,
    required this.titleStr,
    required Vector2 size,
    required Vector2 position,
  }) : super(size: size, position: position);


  late final bgComponent = RectangleComponent(
      size: size ,
      paint: Paint()..color = Colors.blue,
    );
  
  ChangeBGColor (Color bgColor){
    bgComponent.paint.color = bgColor;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 添加一个背景
    add(bgComponent);
    add(RectangleComponent(
      size: size * 0.8,
      paint: Paint()..color = Colors.blueGrey,
      position: Vector2(10, 10),
    ));
    // 添加文字
    add(TextComponent(
      text: titleStr,
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      anchor: Anchor.center,
      position: size / 2,
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onPressed();
  }
}

// // 在游戏中使用
// class MyGame extends FlameGame with HasTappables {
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();

//     // 添加一个自定义的HUD按钮，位置在屏幕右上角
//     final button = HudCustomButton(
//       onPressed: () => print('暂停游戏'),
//       size: Vector2(80, 40),
//       position: Vector2(size.x - 80, 20), // 屏幕右上角，留出20像素的上边距
//     );
//     add(button);
//   }
// }