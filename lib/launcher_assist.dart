import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class AppInfo {
  final String label;
  final Uint8List icon;
  final Uint8List banner;
  final String package;

  AppInfo.fromMap(Map<String, dynamic> map)
      : label = map['label'],
        icon = map['icon'],
        banner = map['banner'],
        package = map['package'];
}

class LauncherAssist {
  static const MethodChannel _channel = const MethodChannel('launcher_assist');

  /// Returns a list of apps installed on the user's device
  static Future<List<AppInfo>> getAllApps() async {
    try {
      List<dynamic> data = await _channel.invokeMethod<List<dynamic>>('getAllApps');
      return data.whereType<Map<dynamic, dynamic>>().map((e) => AppInfo.fromMap(e.cast<String, dynamic>())).toList();
    } catch (e) {
      print('Error getAllApps: $e');
      rethrow;
    }
  }

  /// Launches an app using its package name
  static launchApp(String packageName) {
    _channel.invokeMethod("launchApp", {"packageName": packageName});
  }

  /// Gets you the current wallpaper on the user's device. This method
  /// needs the READ_EXTERNAL_STORAGE permission on Android Oreo.
  static getWallpaper() async {
    var data = await _channel.invokeMethod('getWallpaper');
    return data;
  }
}
