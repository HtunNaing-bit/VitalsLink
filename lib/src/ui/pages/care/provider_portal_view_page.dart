import 'package:flutter/material.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/lab_data_service.dart';
import '../../../services/ai_service.dart';
import '../../../models/lab_result_model.dart';

/// Provider Portal View Page (B2B SaaS Model)
/// Simulates what the provider sees when viewing patient data
class ProviderPortalViewPage extends StatefulWidget {
  const ProviderPortalViewPage({super.key});

  @override
  State<ProviderPortalViewPage> createState() => _ProviderPortalViewPageState();
}

class _ProviderPortalViewPageState extends State<ProviderPortalViewPage> {
  final LabDataService _labDataService = LabDataService();
  final AIService _aiService = AIService();
  List<LabResult> _labResults = [];
  List<AIInsight> _insights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final labResults = await _labDataService.getLabResults();
      final insights = await _aiService.generateDailyInsights();

      setState(() {
        _labResults = labResults;
        _insights =
            insights.where((i) => i.type == InsightType.correlative).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Dr. Smith's Patient Panel"),
            Text(
              'Read-Only',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(StyleTokens.spacing4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Security Warning
                    _buildSecurityWarning(context, themeManager, isDark),
                    const SizedBox(height: StyleTokens.spacing6),
                    // Patient Summary
                    _buildPatientSummary(context, themeManager, isDark),
                    const SizedBox(height: StyleTokens.spacing6),
                    // Lab Results Section
                    if (_labResults.isNotEmpty) ...[
                      _buildSectionHeader(
                          context, 'Lab Results', Icons.science),
                      const SizedBox(height: StyleTokens.spacing3),
                      ..._labResults.take(3).map((result) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: StyleTokens.spacing3),
                            child: _buildLabResultCard(
                                context, result, themeManager, isDark),
                          )),
                      const SizedBox(height: StyleTokens.spacing6),
                    ],
                    // Correlative Insights Section
                    if (_insights.isNotEmpty) ...[
                      _buildSectionHeader(
                          context, 'AI Insights', Icons.auto_awesome),
                      const SizedBox(height: StyleTokens.spacing3),
                      ..._insights.take(1).map((insight) => Padding(
                            padding: const EdgeInsets.only(
                                bottom: StyleTokens.spacing3),
                            child: _buildInsightCard(
                                context, insight, themeManager, isDark),
                          )),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSecurityWarning(
    BuildContext context,
    ThemeManager themeManager,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(StyleTokens.radiusMedium),
        border: Border.all(
          color: Colors.orange,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.security,
            color: Colors.orange,
            size: 24,
          ),
          const SizedBox(width: StyleTokens.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Read-Only Clinical Snapshot',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                ),
                const SizedBox(height: StyleTokens.spacing2),
                Text(
                  'This is a read-only, real-time clinical snapshot for patient monitoring. Data is secured by end-to-end encryption.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientSummary(
    BuildContext context,
    ThemeManager themeManager,
    bool isDark,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 32,
                color: themeManager.currentTheme.primary,
              ),
              const SizedBox(width: StyleTokens.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient: John Doe',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Last Updated: ${DateTime.now().toString().split(' ')[0]}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: StyleTokens.spacing3),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildLabResultCard(
    BuildContext context,
    LabResult result,
    ThemeManager themeManager,
    bool isDark,
  ) {
    final statusIcon = LabResult.getStatusIcon(result.labStatus);
    final statusColor = result.status.toLowerCase() == 'normal'
        ? Colors.green
        : result.status.toLowerCase() == 'high'
            ? Colors.orange
            : Colors.blue;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
          const SizedBox(width: StyleTokens.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.biomarkerName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '${result.value} ${result.unit} • ${result.status}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    AIInsight insight,
    ThemeManager themeManager,
    bool isDark,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.purple,
                size: 24,
              ),
              const SizedBox(width: StyleTokens.spacing3),
              Expanded(
                child: Text(
                  insight.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing3),
          Text(
            insight.snippet,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: StyleTokens.getTextSecondaryStatic(isDark: isDark),
                ),
          ),
          if (insight.sources.isNotEmpty) ...[
            const SizedBox(height: StyleTokens.spacing3),
            Wrap(
              spacing: StyleTokens.spacing2,
              children: insight.sources.map((source) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: StyleTokens.spacing2,
                    vertical: StyleTokens.spacing1,
                  ),
                  decoration: BoxDecoration(
                    color: themeManager.currentTheme.primary.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusSmall),
                  ),
                  child: Text(
                    source.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: themeManager.currentTheme.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
