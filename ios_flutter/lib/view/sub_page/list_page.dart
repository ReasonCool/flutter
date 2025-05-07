import 'package:flutter/material.dart'; // 移除無用的 dart:ffi 導入

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
        backgroundColor: Colors.black12,
      ),
      body: Padding(padding: EdgeInsets.all(20),child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 10,
                color: Colors.red,
                child: _buildList(),
                )
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 10,
                color: Colors.yellow,
                child: _buildList1(),
                )
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 20,
                color: Colors.blue,
                child: _buildList2(),
                )
            ),
             Expanded(
              flex: 1,
              child: Container(
                height: 20,
                color: Colors.green,
                child: _buildListBuilder(),
                )
            ),
          ],
        )) 
    );
  }

  Widget _buildList() {
     
    
    // 需要 return ListView
    return ListView(
      children: [
        const ListTile(title: Text("_buildList 1")), // 提升渲染效能
        const ListTile(title: Text("_buildList 2")),
      ],
    );
  }
  Widget _buildList1() {
    var items = ["items.map a", "items.map b", "items.map c"];
    
    // 需要 return ListView
    return Padding(padding: EdgeInsets.all(10),child: ListView(
      children: items.map((element) => Text(element)).toList(),

    )); 
  }
  Widget _buildList2() {
    var items = ["ListView.builder a", "ListView.builder b", "ListView.builder c"];
    // 需要 return ListView
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(items[index]), // 唯一識別
          title: Text(items[index]),
        );
      }
    );
  }
  Widget _buildListBuilder() {
    var items = ["ListView.builder nTap a", "ListView.builder nTap b", "ListView.builder nTap c"];
    // 需要 return ListView
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          minTileHeight: 0,
          title: Text(items[index]),
          onTap: () => print("Clicked $index"),
        );
      },
    );
  }
}