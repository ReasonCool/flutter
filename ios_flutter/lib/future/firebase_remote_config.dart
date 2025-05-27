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



Future<Map<String, dynamic>> loadRemoteConfigAndVersion() async {

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
 