import 'package:flutter/material.dart';
//json
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
 
import 'package:ios_flutter/model/appversion.dart';

 //firbase
 
import 'package:firebase_remote_config/firebase_remote_config.dart';
 

//get ios app version
 
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universal_io/io.dart';


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
    _loadDataFuture = _loadRemoteConfigAndVersion();
  } 

Future<Map<String, dynamic>> _loadRemoteConfigAndVersion() async {

   final packageInfo = await PackageInfo.fromPlatform();

// 獲取 JSON 字符串
final remoteConfig = FirebaseRemoteConfig.instance;
 final jsonString = remoteConfig.getString('allowVersion');
    // 解析為 Class
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      AppVersion remoteInfo = AppVersion.fromJson(jsonMap);

 bool isAllow = false;
 remoteInfo.appVersion.forEach(<String>(element) => {
  if (element == packageInfo.version){
    isAllow = true
  }
 },);   
 print("isAllow:$isAllow");

  String osVersion = '';  
  if (Platform.isIOS) {
    final versionOS = Platform.operatingSystemVersion;
    final versionFlutter = Platform.version;
    
   osVersion =  'iOS 版本: $versionOS ';
    
  }
  
 return {
      'remoteInfo': jsonString,
      'appVersion': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
      'osVersion': osVersion,
      'isAllow':isAllow.toString(),
    };

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