import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('Hive caches preferences offline', () async {
    final dir = Directory.systemTemp.createTempSync();
    Hive.init(dir.path);
    final box = await Hive.openBox('profile');
    final data = {
      'id': 'user-123',
      'email': 'offline@vitalslink.app',
      'fullName': 'Offline User',
      'role': 'member',
      'preferences': {
        'darkMode': true,
        'notificationsEnabled': false,
        'voiceCoachEnabled': true,
        'privacyLevel': 'vault',
      },
    };
    await box.put('profile', data);
    expect(box.get('profile'), equals(data));
    await box.close();
    dir.deleteSync(recursive: true);
  });
}
