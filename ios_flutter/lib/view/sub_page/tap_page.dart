import 'package:flutter/material.dart';
import 'package:ios_flutter/view/home/home.dart';
import 'package:ios_flutter/view/sub_page/grid_page.dart';
import 'package:ios_flutter/view/sub_page/icon_page.dart';
import 'package:ios_flutter/view/sub_page/text_page.dart';

class TapPage extends StatefulWidget{

  const TapPage({super.key});

  @override
  State<TapPage> createState() => _TapPageState();
}
class _TapPageState extends State<TapPage>{
  late PageController _pageController;
  int _currentIndex = 0;

 @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,   // 初始页面索引
      viewportFraction: 1.0, // 每个页面占视窗的比例（1.0 = 全屏）
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("Tap Page"),),
    body: PageView(
      controller: _pageController,
      onPageChanged: (index) => setState(() {
        _currentIndex = index;
      }),
      children: [HomePage(),IconPage(),ImagePage()],
    ),
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
   @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}