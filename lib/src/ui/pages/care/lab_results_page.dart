import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/lab_data_service.dart';
import '../../../models/lab_result_model.dart';

/// Lab Results Page
class LabResultsPage extends StatefulWidget {
  const LabResultsPage({super.key});

  @override
  State<LabResultsPage> createState() => _LabResultsPageState();
}

class _LabResultsPageState extends State<LabResultsPage> {
  final LabDataService _labDataService = LabDataService();
  List<LabResult> _labResults = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLabResults();
  }

  Future<void> _loadLabResults() async {
    try {
      final results = await _labDataService.getLabResults();
      setState(() {
        _labResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading lab results: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/care'),
        ),
        title: const Text('Lab Results'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _labResults.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.science_outlined,
                          size: 64,
                          color: StyleTokens.getTextSecondaryStatic(
                              isDark: isDark),
                        ),
                        const SizedBox(height: StyleTokens.spacing4),
                        Text(
                          'No lab results available',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: StyleTokens.getTextSecondaryStatic(
                                        isDark: isDark),
                                  ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(StyleTokens.spacing4),
                    itemCount: _labResults.length,
                    itemBuilder: (context, index) {
                      final result = _labResults[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: StyleTokens.spacing3),
                        child: LabResultCard(
                          result: result,
                          themeManager: themeManager,
                          isDark: isDark,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

/// Lab Result Card Component
class LabResultCard extends StatelessWidget {
  final LabResult result;
  final ThemeManager themeManager;
  final bool isDark;

  const LabResultCard({
    super.key,
    required this.result,
    required this.themeManager,
    required this.isDark,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'high':
        return Colors.orange;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(result.status);

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.biomarkerName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: StyleTokens.spacing1),
                    Text(
                      'Tested ${_formatDate(result.timestamp)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: StyleTokens.spacing3,
                  vertical: StyleTokens.spacing1,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
                  border: Border.all(
                    color: statusColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  result.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Value Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                result.value.toStringAsFixed(
                    result.value.truncateToDouble() == result.value ? 0 : 1),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeManager.currentTheme.primary,
                    ),
              ),
              const SizedBox(width: StyleTokens.spacing2),
              Text(
                result.unit,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                    ),
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing2),
          // Reference Range
          Text(
            'Reference Range: ${result.referenceRange}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                ),
          ),
          const SizedBox(height: StyleTokens.spacing3),
          // Trend (Placeholder)
          Container(
            padding: const EdgeInsets.all(StyleTokens.spacing3),
            decoration: BoxDecoration(
              color: themeManager.currentTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(StyleTokens.radiusSmall),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  size: 16,
                  color: themeManager.currentTheme.primary,
                ),
                const SizedBox(width: StyleTokens.spacing2),
                Text(
                  'Up 5% from last test',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: themeManager.currentTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}
