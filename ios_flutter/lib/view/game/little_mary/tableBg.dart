import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:flame/game.dart';
class BackgroundAnimationSystem extends Component with HasGameReference<FlameGame> {
  final List<SpriteComponent> spriteComponents;
  late Timer _timer;
  int currentIndex = 0;
  bool isAnimating = false;

  BackgroundAnimationSystem(this.spriteComponents) {
    // 设置每3秒触发一次的计时器
    _timer = Timer(3, repeat: true, onTick: _updateAnimation);
     print('tableBG.dart BackgroundAnimationSystem');
  }

  @override
  void onMount() {
    super.onMount();
     print('tableBG.dart onMount');
    // 在组件挂载后开始动画
    startAnimation();
  }

  void startAnimation() {
    if (isAnimating) return;
    
    isAnimating = true;
    // 确保所有精灵初始为透明
    for (final sprite in spriteComponents) {
      sprite.opacity = 0;
    }
    // 显示第一个精灵
    spriteComponents[currentIndex].opacity = 1;
    // 开始计时器
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    print('tableBG.dart update');
    if (isAnimating) {
      _timer.update(dt);
    }
  }

  void _updateAnimation() {
    if (!isAnimating) return;
    
    // 当前精灵淡出
    spriteComponents[currentIndex].opacity = 0;
    
    // 计算下一个索引
    final nextIndex = (currentIndex + 1) % spriteComponents.length;
    
    // 下一个精灵淡入
    spriteComponents[nextIndex].opacity = 1;
    
    currentIndex = nextIndex;
  }

  @override
  void onRemove() {
    _timer.stop();
    super.onRemove();
  }
}