import 'package:json_annotation/json_annotation.dart';

part 'appversion.g.dart'; // 自動生成的文件

@JsonSerializable()
class AppVersion {
  final List<String> appVersion;

  AppVersion({required this.appVersion});

  // 自動生成的 fromJson
  factory AppVersion.fromJson(Map<String, dynamic> json) =>
      _$AppVersionFromJson(json);

  // 自動生成的 toJson
  Map<String, dynamic> toJson() => _$AppVersionToJson(this);
}

 