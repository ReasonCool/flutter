import 'package:flutter/material.dart';
class ImagePage extends StatelessWidget {
  const ImagePage({super.key});
   
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ImagePage')),
      body:Flex(
        direction: Axis.vertical,
        children: [
         // Expanded(child: GridView(gridDelegate: ,))
        ],),
    );
  }
}