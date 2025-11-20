import 'package:cloud_functions/cloud_functions.dart';
import '../../../core/firebase/firebase_config.dart';
import '../../../core/error/exceptions.dart';

/// Firebase Functions Data Source
/// Handles all Cloud Functions calls
class FirebaseFunctionsDataSource {
  final FirebaseFunctions _functions;

  FirebaseFunctionsDataSource() : _functions = FirebaseConfig.functions;

  /// Call a Cloud Function
  Future<Map<String, dynamic>> callFunction({
    required String functionName,
    Map<String, dynamic>? data,
  }) async {
    try {
      final callable = _functions.httpsCallable(functionName);
      final result = await callable.call(data ?? {});
      return result.data as Map<String, dynamic>;
    } on FirebaseFunctionsException catch (e) {
      throw ServerException('Function call failed: ${e.message}');
    } catch (e) {
      throw ServerException('Unexpected error during function call: $e');
    }
  }

  /// Call AI chat function
  Future<Map<String, dynamic>> chatWithAI({
    required String message,
    List<Map<String, dynamic>>? history,
  }) async {
    return await callFunction(
      functionName: 'chatWithAI',
      data: {
        'message': message,
        'history': history ?? [],
      },
    );
  }

  /// Generate health insights
  Future<Map<String, dynamic>> generateInsights({
    required Map<String, dynamic> healthData,
    Map<String, dynamic>? journalData,
  }) async {
    return await callFunction(
      functionName: 'generateInsights',
      data: {
        'healthData': healthData,
        'journalData': journalData,
      },
    );
  }
}

