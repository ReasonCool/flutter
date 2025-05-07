import 'package:flutter/material.dart';

class StackPage extends StatelessWidget {
  const StackPage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column Row and Container'),backgroundColor: Colors.black12,),
      body:  Center(
        child: SizedBox(
          width: 200,
          height: 150,
          child: Stack(
            clipBehavior: Clip.none, //允許部件超出範圍
            children: [
              // 背景圖片
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/300/400'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 左上角標題
                Positioned(
                  left: 20,
                  top: 20,
                  child: Text(
                    '旅行日記',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
                    ),
                  ),
                ),

                // 右下角副標題
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Text(
                    '探索未知的世界',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // 中間浮動按鈕
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.star, color: Colors.white),
                      label: Text('收藏', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        print('按鈕被點擊！');
                      },
                    ),
                  ),
                ),

                // 右上角角標
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'NEW',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
    