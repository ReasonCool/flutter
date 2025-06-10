import 'package:flutter/material.dart';
import 'package:ios_flutter/view/sub_page/count_page.dart';

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({super.key});

  @override
  Widget build(BuildContext context) {
    return CounterPage();
    //随便返回一个Text()
  //return Text("xxx");
  }
}