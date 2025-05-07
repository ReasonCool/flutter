

import 'package:flutter/material.dart';
import 'package:ios_flutter/Home/app_context.dart';


void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: const HomePage(),
      initialRoute: AppRoutes.homeName.path,
      routes: AppRoutes.routes ,
    );
  }
}



