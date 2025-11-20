import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../components/glass_card.dart';
import '../../components/review_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/review_service.dart';
import '../../../services/telehealth_service.dart';

/// Care Hub Screen with Telehealth & Reviews
class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ReviewService _reviewService = ReviewService();
  final TelehealthService _telehealthService = TelehealthService();
  List<Review> _doctorReviews = [];
  List<Doctor> _doctors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initialize();
  }

  Future<void> _initialize() async {
    await _telehealthService.initialize();
    await _loadDoctors();
    await _loadReviews();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadDoctors() async {
    final doctors = await _telehealthService.getDoctors();
    setState(() {
      _doctors = doctors;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadReviews() async {
    await _reviewService.initialize();
    final reviews = _reviewService.getReviews(type: 'doctor');
    setState(() {
      _doctorReviews = reviews;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(l10n.careHub),
        bottom: TabBar(
          controller: _tabController,
          labelColor: themeManager.currentTheme.primary,
          unselectedLabelColor:
              StyleTokens.getTextSecondaryStatic(isDark: isDark),
          indicatorColor: themeManager.currentTheme.primary,
          tabs: [
            Tab(text: l10n.providers),
            Tab(text: l10n.reviews),
            Tab(text: l10n.labResults),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProvidersTab(context, themeManager, isDark),
          _buildReviewsTab(context, themeManager, isDark),
          _buildLabResultsTab(context),
        ],
      ),
    );
  }

  Widget _buildProvidersTab(
    BuildContext context,
    ThemeManager themeManager,
    bool isDark,
  ) {
    final l10n = AppLocalizations.of(context)!;
    
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 64,
              color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
            ),
            const SizedBox(height: StyleTokens.spacing4),
            Text(
              l10n.noProvidersAvailable,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        final reviews =
            _reviewService.getReviewsForEntity(doctor.id, type: 'doctor');
        final avgRating = reviews.isEmpty
            ? doctor.rating
            : _reviewService.getAverageRating(doctor.id, type: 'doctor');

        return Padding(
          padding: const EdgeInsets.only(bottom: StyleTokens.spacing4),
          child: GlassCard(
            padding: const EdgeInsets.all(StyleTokens.spacing4),
            onTap: () => _showBookingDialog(context, doctor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Doctor Avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          themeManager.currentTheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: themeManager.currentTheme.primary,
                      ),
                    ),
                    const SizedBox(width: StyleTokens.spacing4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            doctor.specialty,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: StyleTokens.getTextSecondaryStatic(
                                          isDark: isDark),
                                    ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                avgRating.toStringAsFixed(1),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                ' (${l10n.reviewsCount(reviews.length)})',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: StyleTokens.getTextSecondaryStatic(
                                          isDark: isDark),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                    ),
                  ],
                ),
                const SizedBox(height: StyleTokens.spacing3),
                ElevatedButton(
                  onPressed: () => _showBookingDialog(context, doctor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeManager.currentTheme.primary,
                    foregroundColor: themeManager.currentTheme.accentContrast,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(StyleTokens.radiusMedium),
                    ),
                  ),
                  child: Text(l10n.bookConsultation),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab(
    BuildContext context,
    ThemeManager themeManager,
    bool isDark,
  ) {
    final l10n = AppLocalizations.of(context)!;
    
    if (_doctorReviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.reviews_outlined,
              size: 64,
              color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
            ),
            const SizedBox(height: StyleTokens.spacing4),
            Text(
              l10n.noReviewsYet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      itemCount: _doctorReviews.length,
      itemBuilder: (context, index) {
        final review = _doctorReviews[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
          child: ReviewCard(
            rating: review.rating,
            reviewText: review.reviewText,
            reviewerName: review.reviewerName ?? AppLocalizations.of(context)!.anonymous,
            timestamp: review.timestamp,
          ),
        );
      },
    );
  }

  Future<void> _showBookingDialog(BuildContext context, Doctor doctor) async {
    final l10n = AppLocalizations.of(context)!;
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.bookConsultation),
        content: Text(l10n.bookAConsultationWith(doctor.name)),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            child: Text(l10n.book),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await _telehealthService.bookConsultation(
          doctorId: doctor.id,
          preferredTime: DateTime.now().add(const Duration(days: 1)),
          reason: 'General consultation',
        );

        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.consultationBookedSuccessfully),
              backgroundColor: ThemeManager().currentTheme.primary,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorBookingConsultation(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildLabResultsTab(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(StyleTokens.spacing4),
        child: GlassCard(
          padding: const EdgeInsets.all(StyleTokens.spacing6),
          onTap: () => context.go('/care/lab-results'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.science,
                size: 64,
                color: ThemeManager().currentTheme.primary,
              ),
              const SizedBox(height: StyleTokens.spacing4),
              Text(
                l10n.viewLabResults,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: StyleTokens.spacing2),
              Text(
                l10n.accessYourLabTestResults,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: StyleTokens.spacing4),
              ElevatedButton(
                onPressed: () => context.go('/care/lab-results'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeManager().currentTheme.primary,
                  foregroundColor: ThemeManager().currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                    horizontal: StyleTokens.spacing6,
                    vertical: StyleTokens.spacing4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
                child: Text(l10n.viewLabResults),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
