import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/models/user.dart';
import '../mocks/mock_data.dart';

final userBoxProvider = Provider<Box<dynamic>>(
  (ref) => throw UnimplementedError(),
);

final userProvider = FutureProvider<AppUser>((ref) async {
  try {
    final box = ref.watch(userBoxProvider);
    final cached = box.get('profile') as Map<String, dynamic>?;
    if (cached != null) {
      return AppUser.fromJson(Map<String, dynamic>.from(cached));
    }
  } catch (_) {
    // ignore caching issues
  }
  return MockData.mockUser;
});
