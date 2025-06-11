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

  
  final spriteInfos = await createSpriteInfos(tablePath,tableNames );
  final spriteComponents =   createPlayTablePosition(spriteInfos);

  spriteComponents.forEach((item)=> world.add(item)); 

}

List<SpriteComponent> createPlayTablePosition(List<Sprite> spriteInfos){

   double x1 = 0;
   double y1 = 0;
   double scaleValue = (820/7)/120;
   int row = 1;
   
   bool isLeft = true;
   int index = 0;
   int maxColumn = 7;
    
   
   return spriteInfos.map((spriteInfo){  
     
      index ++;
       if(index <= maxColumn   ){
        row = 1;
        if(index > 1){
           x1 +=  120;
        }
       
        y1 = 0;
       }else if(index <= (spriteInfos.length - maxColumn )){
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
        if(index ==  (spriteInfos.length - maxColumn ) + 1){
          row++;
          x1 = 0;
          y1 += 120;
        
        }else{
           x1 +=  120;

        }
       } 

      
      
      
     
      final spriteComponent =   SpriteComponent(sprite:spriteInfo ,position: Vector2(x1*scaleValue, y1*scaleValue),scale: Vector2(scaleValue,scaleValue));
    
      return spriteComponent;
    }).toList(); 
  }


Future< List<Sprite>> createSpriteInfos(String tablePath,List<String> tableNames) async{

    
   
    List<String> tablePaths = tableNames.map((name) => '$tablePath$name.png').toList();

  final imageInfos = await images.loadAll(tablePaths);

  return imageInfos.map((imageInfo){  
    return Sprite(imageInfo,srcPosition:Vector2(0,0),srcSize: Vector2(  120 ,  120));
  }).toList();
  }
 
  
}