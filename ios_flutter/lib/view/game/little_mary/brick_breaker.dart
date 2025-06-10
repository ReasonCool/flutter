import 'dart:async';
import 'dart:ffi';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components.dart';
import 'config.dart';


class BrickBreaker extends FlameGame {
  BrickBreaker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();


camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    final tablePath = 'resource/images/little_mary/table/';
    final tableNames = [  'bar', 'bar25', 'bar50', 'bell'  ];
    //final tableNames = [
    //   'apple', 'bar', 'bar25', 'bar50', 'bell','bell_multiple_2', 'melon',
    //   'melon_multiple_2', 'once_more', 'orange', 'orange_multiple_2', 'seven',
    //   'seven_multiple_2', 'star', 'star_multiple_2', 'water_melon', 'water_melon_multiple_2'
    // ];
    //bell_multiple_2.png
//"assets/images/resource/images/little_mary/table/bell_multiple_2.png
    // Corrected solution:
    List<String> tablePaths = tableNames.map((name) => '$tablePath$name.png').toList();

  final imageInfos = await images.loadAll(tablePaths);
 
   double x1 = 0;
   double y1 = 0;
   int index = 0;
   final spriteComponents =  imageInfos.map((imageInfo){  
      // if (x1 >= gameWidth) {
      //   x1 = 0;
      //   index += 1;
        
      // }
    
       final vec =  Vector2(-x1, y1);
      final spriteComponent =   SpriteComponent(sprite: Sprite(imageInfo,srcPosition:vec,srcSize: Vector2(x1+120 ,120)));
      if( index == 0 || index == imageInfos.length-1){
        x1 +=  120;
      }else{
        x1 = gameWidth - 120;
      }  
      
      return spriteComponent;
    }).toList();
 

    

  spriteComponents.forEach((item)=> world.add(item)); 

  }
}