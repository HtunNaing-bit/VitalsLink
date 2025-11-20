import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();

  static final SupabaseService instance = SupabaseService._();
  final Logger _logger = Logger();

  SupabaseClient get client => Supabase.instance.client;

  Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    _logger.i('Supabase initialized');
  }

  Future<void> signInWithEmail(String email) {
    return client.auth.signInWithOtp(email: email);
  }

  Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      final response = await client.from('profiles').select().maybeSingle();
      return response;
    } catch (error, stack) {
      _logger.e('Failed to fetch profile', error: error, stackTrace: stack);
      return null;
    }
  }
}
