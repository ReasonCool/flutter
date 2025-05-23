import 'package:flutter/material.dart';

import 'package:sensors_plus/sensors_plus.dart';
import '../game/sample1/game_app.dart';
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
 // late final MyWorld _game;
 

  @override
  void initState() {
    super.initState();
    //_game = SlotMachineGame();
    
  
  
  
  }

 
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('遊戲一'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:const GameApp()
     // body:GameWidget(game:BrickBreaker()),
      // body:  GameWidget(
      //     game: FlameGame(world: MyWorld()),
      //   ),
        
     
    );
  }

  @override
  void dispose() {
    //_game.onRemove();
    
    super.dispose();
  }
}
