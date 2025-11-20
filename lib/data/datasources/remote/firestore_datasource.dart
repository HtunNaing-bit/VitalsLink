import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/firebase/firebase_config.dart';
import '../../../core/error/exceptions.dart';

/// Firestore Data Source
/// Handles all Firestore database operations
class FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSource() : _firestore = FirebaseConfig.firestore;

  /// Create a document
  Future<void> create<T>({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collection).doc(id).set(data);
    } catch (e) {
      throw ServerException('Failed to create document: $e');
    }
  }

  /// Read a document
  Future<Map<String, dynamic>?> read({
    required String collection,
    required String id,
  }) async {
    try {
      final doc = await _firestore.collection(collection).doc(id).get();
      if (!doc.exists) return null;
      return doc.data();
    } catch (e) {
      throw ServerException('Failed to read document: $e');
    }
  }

  /// Update a document
  Future<void> update({
    required String collection,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
    } catch (e) {
      throw ServerException('Failed to update document: $e');
    }
  }

  /// Delete a document
  Future<void> delete({
    required String collection,
    required String id,
  }) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      throw ServerException('Failed to delete document: $e');
    }
  }

  /// Query documents
  Future<List<Map<String, dynamic>>> query({
    required String collection,
    Query Function(Query)? queryBuilder,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collection);
      
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      
      if (limit != null) {
        query = query.limit(limit);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw ServerException('Failed to query documents: $e');
    }
  }

  /// Stream documents
  Stream<List<Map<String, dynamic>>> stream({
    required String collection,
    Query Function(Query)? queryBuilder,
    int? limit,
  }) {
    try {
      Query query = _firestore.collection(collection);
      
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      
      if (limit != null) {
        query = query.limit(limit);
      }
      
      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      throw ServerException('Failed to stream documents: $e');
    }
  }
}

