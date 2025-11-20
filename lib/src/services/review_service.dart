import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Review Service with Local Storage
class ReviewService {
  static final ReviewService _instance = ReviewService._internal();
  factory ReviewService() => _instance;
  ReviewService._internal();

  static const String _storageKey = 'vitalslink_reviews';
  List<Review> _reviews = [];

  /// Initialize and load reviews
  Future<void> initialize() async {
    await _loadReviews();
  }

  /// Get all reviews
  List<Review> getReviews({String? type}) {
    if (type != null) {
      return _reviews.where((r) => r.type == type).toList();
    }
    return List.from(_reviews);
  }

  /// Get reviews for a specific entity (doctor, AI insight, etc.)
  List<Review> getReviewsForEntity(String entityId, {String? type}) {
    return _reviews
        .where(
            (r) => r.entityId == entityId && (type == null || r.type == type))
        .toList();
  }

  /// Submit a new review
  Future<void> submitReview(Review review) async {
    _reviews.add(review);
    await _saveReviews();
  }

  /// Update a review
  Future<void> updateReview(String reviewId, Review updatedReview) async {
    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      _reviews[index] = updatedReview;
      await _saveReviews();
    }
  }

  /// Delete a review
  Future<void> deleteReview(String reviewId) async {
    _reviews.removeWhere((r) => r.id == reviewId);
    await _saveReviews();
  }

  /// Get average rating for an entity
  double getAverageRating(String entityId, {String? type}) {
    final entityReviews = getReviewsForEntity(entityId, type: type);
    if (entityReviews.isEmpty) return 0.0;

    final totalRating = entityReviews.fold<int>(
      0,
      (sum, review) => sum + review.rating,
    );
    return totalRating / entityReviews.length;
  }

  /// Load reviews from storage
  Future<void> _loadReviews() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _reviews = jsonList.map((json) => Review.fromJson(json)).toList();
      } else {
        // Load initial mock data
        await _loadMockReviews();
      }
    } catch (e) {
      // Load mock data on error
      await _loadMockReviews();
    }
  }

  /// Save reviews to storage
  Future<void> _saveReviews() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(
        _reviews.map((r) => r.toJson()).toList(),
      );
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      // Handle error
    }
  }

  /// Load initial mock reviews
  Future<void> _loadMockReviews() async {
    try {
      final jsonString = await rootBundle.loadString('mocks/reviews.json');
      final Map<String, dynamic> json = jsonDecode(jsonString);
      final List<dynamic> reviewsList = json['reviews'] as List;
      _reviews = reviewsList.map((r) => Review.fromJson(r)).toList();
      await _saveReviews();
    } catch (e) {
      // No mock data available
      _reviews = [];
    }
  }
}

/// Review Model
class Review {
  final String id;
  final String type; // 'doctor', 'ai_insight', 'provider'
  final String entityId; // ID of the entity being reviewed
  final String? entityName; // Name of the entity
  final int rating; // 1-5 stars
  final String? reviewText;
  final String? reviewerName;
  final DateTime timestamp;

  Review({
    required this.id,
    required this.type,
    required this.entityId,
    this.entityName,
    required this.rating,
    this.reviewText,
    this.reviewerName,
    required this.timestamp,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      type: json['type'] as String,
      entityId: json['entity_id'] as String,
      entityName: json['entity_name'] as String?,
      rating: json['rating'] as int,
      reviewText: json['review_text'] as String?,
      reviewerName: json['reviewer_name'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'entity_id': entityId,
      'entity_name': entityName,
      'rating': rating,
      'review_text': reviewText,
      'reviewer_name': reviewerName,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
