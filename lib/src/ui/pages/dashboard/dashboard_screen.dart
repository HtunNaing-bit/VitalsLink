import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../components/glass_card.dart';
import '../../components/insight_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/ai_service.dart';

/// Main Dashboard Screen
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AIService _aiService = AIService();
  List<AIInsight> _insights = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInsights();
  }

  Future<void> _loadInsights() async {
    try {
      final insights = await _aiService.generateDailyInsights();
      setState(() {
        _insights = insights;
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
    final l10n = AppLocalizations.of(context)!;
    final themeManager = ThemeManager();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(l10n),
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        DateTime.now().toString().split(' ')[0],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: StyleTokens.getTextSecondaryStatic(
                                  isDark: isDark),
                            ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () => context.go('/notifications'),
                  ),
                ],
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      icon: Icons.bedtime,
                      label: l10n.sleep,
                      value: '7h 32m',
                      color: themeManager.currentTheme.primary,
                    ),
                  ),
                  const SizedBox(width: StyleTokens.spacing3),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      icon: Icons.battery_charging_full,
                      label: l10n.energy,
                      value: '85%',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: StyleTokens.spacing3),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      icon: Icons.mood,
                      label: l10n.mood,
                      value: l10n.great,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: StyleTokens.spacing3),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      icon: Icons.directions_walk,
                      label: l10n.steps,
                      value: '8,234',
                      color: themeManager.currentTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Scenario Planner Card
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing5),
                onTap: () => context.go('/dashboard/scenario-planner'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 28,
                          color: themeManager.currentTheme.primary,
                        ),
                        const SizedBox(width: StyleTokens.spacing3),
                        Expanded(
                          child: Text(
                            l10n.scenarioPlanner,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: StyleTokens.getTextSecondaryStatic(
                              isDark: isDark),
                        ),
                      ],
                    ),
                    const SizedBox(height: StyleTokens.spacing3),
                    Text(
                      l10n.scenarioPlannerDescription,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // AI Insight Card
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_insights.isNotEmpty)
                InsightCard(insight: _insights.first),
              const SizedBox(height: StyleTokens.spacing6),
            ],
          ),
        ),
      ),
      // Floating Ask VitalsLink Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/ai-chat'),
        backgroundColor: themeManager.currentTheme.primary,
        foregroundColor: themeManager.currentTheme.accentContrast,
        icon: const Icon(Icons.chat_bubble_outline),
        label: Text('Ask ${l10n.appName}'),
      ),
      // Bottom Navigation
      bottomNavigationBar: _buildBottomNav(context, themeManager),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: StyleTokens.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            StyleTokens.getTextSecondaryStatic(isDark: isDark),
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, ThemeManager themeManager) {
    final l10n = AppLocalizations.of(context)!;
    
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: themeManager.currentTheme.primary,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/journal');
            break;
          case 2:
            context.go('/ai-chat');
            break;
          case 3:
            context.go('/care');
            break;
          case 4:
            context.go('/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.book_outlined),
          activeIcon: const Icon(Icons.book),
          label: l10n.journal,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_bubble_outline),
          activeIcon: const Icon(Icons.chat_bubble),
          label: l10n.aiChat,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.medical_services_outlined),
          activeIcon: const Icon(Icons.medical_services),
          label: l10n.care,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: l10n.profile,
        ),
      ],
    );
  }

  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}
