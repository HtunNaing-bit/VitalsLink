import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/services/supabase_service.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  final client = SupabaseService.instance.client;
  return client.auth.onAuthStateChange;
});
