import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class ColoredTextSprite extends PositionComponent {
  final Color backgroundColor;
  final String text;
  final TextStyle textStyle;
  final Vector2 colorSize;
  
  ColoredTextSprite({
    required this.backgroundColor,
    required this.text,
    required this.colorSize,
    this.textStyle = const TextStyle(color: Color.fromARGB(255, 232, 228, 228), fontSize: 30),
    super.position 
  }) : super(size: colorSize);

  late final TextComponent textComponent ;

  editTextValue(String textStr){

    textComponent.text = textStr;
  }
  editTextValueAni(String textStr) async{
    final startNum = int.tryParse(text)??0 ;
    final endNum =  int.tryParse(textStr)??0 ;
    var list;
    if(startNum < endNum){
     list = [for (var i = startNum; i <= endNum; i++) i];
    }else if(startNum > endNum){
      list = [for (var i = startNum; i <= endNum; i--) i];
    }
    for (var i in list){
      textComponent.text = i.toString();
       await Future.delayed(Duration(milliseconds: 300));
    }

    textComponent.text = textStr;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Add background rectangle
    add(RectangleComponent(
      size: size,
      paint: BasicPalette.transparent.paint()..color = backgroundColor,
    ));
    
    // Add text component
    textComponent = TextComponent(
      text: text,
      textRenderer: TextPaint(style: textStyle),
      anchor: Anchor.center,
      position: size / 2,
    );
    
    add(textComponent);
  }
}
