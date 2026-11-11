import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NativeService {
  static const MethodChannel _channel = MethodChannel('meme_app/person1');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      debugPrint('Failed to show toast: ${e.message}');
    }
  }

  static Future<String> getDeviceInfo() async {
    try {
      final String result = await _channel.invokeMethod('getDeviceInfo');
      return result;
    } on PlatformException catch (e) {
      return 'Failed to get device info: ${e.message}';
    }
  }

  static Future<int> getBatteryLevel() async {
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException {
      return -1;
    }
  }

  static Future<String> getScreenInfo() async {
    try {
      final String result = await _channel.invokeMethod('getScreenInfo');
      return result;
    } on PlatformException {
      return 'Unknown';
    }
  }
}

