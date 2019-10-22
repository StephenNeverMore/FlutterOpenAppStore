import 'dart:async';

import 'package:flutter/services.dart';

class FlutterOpenAppStore {
  static const MethodChannel _channel =
      const MethodChannel('flutter_open_app_store');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> openAppStore(
      {String androidAppId, String iosAppId}) async {
    return await _channel.invokeMethod(
        'openAppStore', {'android_id': androidAppId, 'ios_id': iosAppId});
  }
}
