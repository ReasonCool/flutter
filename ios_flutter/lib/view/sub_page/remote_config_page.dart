import 'package:flutter/material.dart'; 
import 'package:ios_flutter/future/firebase_remote_config.dart';

class RemoteConfigPage extends StatefulWidget{
  const RemoteConfigPage ({Key? key}) : super (key:key);

  @override
  State<RemoteConfigPage> createState() => _RemoteConfigPageState();
}
class _RemoteConfigPageState extends State<RemoteConfigPage>{
late Future<Map<String, dynamic>> _loadDataFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDataFuture = loadRemoteConfigAndVersion();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Remote Config Page")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          // 顯示載入動畫
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // 錯誤處理
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          

          // 取得資料後的顯示
          final data = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoRow('OS Version', data['osVersion']),
              _buildInfoRow('App Version', data['appVersion']),
              _buildInfoRow('Build Number', data['buildNumber']),
              _buildInfoRow('Remote Config', data['remoteInfo'].toString()),
              _buildInfoRow('is Allow Version', data['isAllow']),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$title: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}