import 'dart:io';

import 'package:flutter/services.dart';

class GoogleFitAdapter {
  static const MethodChannel _channel = MethodChannel('vitalslink/google_fit');

  Future<void> requestPermissions() async {
    if (!Platform.isAndroid) return;
    try {
      await _channel.invokeMethod<void>('requestPermissions');
    } on PlatformException {
      // ignore in mock mode
    }
  }

  Future<Map<String, dynamic>> fetchSamples() async {
    if (!Platform.isAndroid) return <String, dynamic>{};
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>(
        'fetchSamples',
      );
      return result ?? <String, dynamic>{};
    } on PlatformException {
      return <String, dynamic>{};
    }
  }
}
