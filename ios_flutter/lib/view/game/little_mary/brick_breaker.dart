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


final spriteComponents = await createPlayTable();
    

  spriteComponents.forEach((item)=> world.add(item)); 

  }

  Future< List<SpriteComponent>> createPlayTable() async{
        final tablePath = 'resource/images/little_mary/table/';
    //final tableNames = [  'bar', 'bar25', 'bar50', 'bell'  ];
    final tableNames = [
       'orange','bell','bar50','bar','bar25','apple','melon',
       'bell_multiple_2', 'water_melon',
       'apple','water_melon_multiple_2',
       'once_more', 'once_more', 
       'star_multiple_2', 'apple',
       'star','orange_multiple_2',
       'melon','melon_multiple_2','apple','seven','seven_multiple_2','bell','orange',
    ];
    // final tableNames = [
    //   'apple', 'bar', 'bar25', 'bar50', 'bell','bell_multiple_2', 'melon',
    //   'melon_multiple_2', 'once_more', , 'orange_multiple_2', 'seven',
    //   'seven_multiple_2', 'star', 'star_multiple_2', 'water_melon', 'water_melon_multiple_2'
    // ];
    //bell_multiple_2.png
//"assets/images/resource/images/little_mary/table/bell_multiple_2.png
    // Corrected solution:
    List<String> tablePaths = tableNames.map((name) => '$tablePath$name.png').toList();

  final imageInfos = await images.loadAll(tablePaths);
 
   double x1 = 0;
   double y1 = 0;
   double scaleValue = (820/7)/120;
   int row = 1;
   
   bool isLeft = true;
   int index = 0;
   int maxColumn = 7;
    
   
   return imageInfos.map((imageInfo){  
      index ++;
       if(index <= maxColumn   ){
        row = 1;
        if(index > 1){
           x1 +=  120;
        }
       
        y1 = 0;
       }else if(index <= (imageInfos.length - maxColumn )){
        if(isLeft == true){
          row++;
          isLeft = false;
          x1 = 0;
          y1 += 120;
        }else{
          isLeft = true;
          x1 = ((120 * 6) as num).toDouble()  ;
        }
        
       }else{
        //last row 
        if(index ==  (imageInfos.length - maxColumn ) + 1){
          row++;
          x1 = 0;
          y1 += 120;
        
        }else{
           x1 +=  120;

        }
       } 

      print('Vector2 Int(-$x1 , $y1 );');

      
      
      final spriteInfo = Sprite(imageInfo,srcPosition:Vector2(0,0),srcSize: Vector2(  120 ,y1 + 120));
      final spriteComponent =   SpriteComponent(sprite:spriteInfo ,position: Vector2(x1*scaleValue, y1*scaleValue),scale: Vector2(scaleValue,scaleValue));
    
      return spriteComponent;
    }).toList(); 
  }
}