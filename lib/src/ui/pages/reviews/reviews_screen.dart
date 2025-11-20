import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../l10n/app_localizations.dart';
import '../../components/review_card.dart';
import '../../../services/review_service.dart';
import '../../../utils/style_tokens.dart';

/// Reviews & Reflection Screen
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ReviewService _reviewService = ReviewService();
  List<Review> _allReviews = [];
  List<Review> _doctorReviews = [];
  List<Review> _aiInsightReviews = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadReviews();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadReviews() async {
    await _reviewService.initialize();
    setState(() {
      _allReviews = _reviewService.getReviews();
      _doctorReviews = _reviewService.getReviews(type: 'doctor');
      _aiInsightReviews = _reviewService.getReviews(type: 'ai_insight');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviewsAndReflection),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddReviewDialog(
                  type: 'ai_insight',
                  entityId: 'insight_001',
                  entityName: l10n.aiInsights,
                ),
              ).then((_) => _loadReviews());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: themeManager.currentTheme.primary,
              unselectedLabelColor:
                  StyleTokens.getTextSecondaryStatic(isDark: isDark),
              indicatorColor: themeManager.currentTheme.primary,
              tabs: [
                Tab(text: l10n.allReviews),
                Tab(text: l10n.doctors),
                Tab(text: l10n.aiInsights),
              ],
            ),
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildReviewsList(_allReviews, 'all'),
                  _buildReviewsList(_doctorReviews, 'doctor'),
                  _buildReviewsList(_aiInsightReviews, 'ai_insight'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsList(List<Review> reviews, String type) {
    if (reviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.reviews_outlined,
              size: 64,
              color: StyleTokens.getTextSecondaryStatic(
                isDark: Theme.of(context).brightness == Brightness.dark,
              ),
            ),
            const SizedBox(height: StyleTokens.spacing4),
            Text(
              'No reviews yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: StyleTokens.getTextSecondaryStatic(
                      isDark: Theme.of(context).brightness == Brightness.dark,
                    ),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
          child: ReviewCard(
            rating: review.rating,
            reviewText: review.reviewText,
            reviewerName: review.reviewerName ?? 'Anonymous',
            timestamp: review.timestamp,
          ),
        );
      },
    );
  }
}

/// Add Review Dialog
class AddReviewDialog extends StatefulWidget {
  final String type;
  final String entityId;
  final String? entityName;

  const AddReviewDialog({
    super.key,
    required this.type,
    required this.entityId,
    this.entityName,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  int _rating = 0;
  String _reviewText = '';
  final ReviewService _reviewService = ReviewService();
  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(StyleTokens.radiusLarge),
      ),
      child: Container(
        padding: const EdgeInsets.all(StyleTokens.spacing5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Review',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (widget.entityName != null) ...[
              const SizedBox(height: StyleTokens.spacing2),
              Text(
                widget.entityName!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: StyleTokens.getTextSecondaryStatic(
                        isDark: Theme.of(context).brightness == Brightness.dark,
                      ),
                    ),
              ),
            ],
            const SizedBox(height: StyleTokens.spacing4),
            ReviewCard(
              rating: _rating,
              reviewText: _reviewText,
              isEditable: true,
              onRatingChanged: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
              onReviewChanged: (text) {
                setState(() {
                  _reviewText = text;
                });
              },
              onSubmit: _submitReview,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    if (_rating == 0) return;

    final review = Review(
      id: _uuid.v4(),
      type: widget.type,
      entityId: widget.entityId,
      entityName: widget.entityName,
      rating: _rating,
      reviewText: _reviewText.isEmpty ? null : _reviewText,
      reviewerName: 'You', // Replace with actual user name
      timestamp: DateTime.now(),
    );

    await _reviewService.submitReview(review);
    if (mounted) {
      context.pop();
    }
  }
}
