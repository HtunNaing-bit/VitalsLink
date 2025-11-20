import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/services/analytics_service.dart';
import '../../../../widgets/animated_gradient_bg.dart';
import '../../../../src/ui/components/glass_card.dart';
import '../../../../widgets/pro_bottom_nav.dart';

/// Insights & Reports screen with animated charts
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
    AnalyticsService().trackScreenView('insights');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _InsightsHeader(),

              // Tabs
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Sleep'),
                  Tab(text: 'Recovery'),
                  Tab(text: 'Activity'),
                  Tab(text: 'Nutrition'),
                ],
              ),

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    _SleepInsights(),
                    _RecoveryInsights(),
                    _ActivityInsights(),
                    _NutritionInsights(),
                  ],
                ),
              ),

              // Bottom navigation
              ProBottomNav(
                currentIndex: 2,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/dashboard');
                      break;
                    case 1:
                      context.go('/coach');
                      break;
                    case 2:
                      context.go('/insights');
                      break;
                    case 3:
                      context.go('/profile');
                      break;
                  }
                },
                items: const [
                  NavItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      route: '/dashboard'),
                  NavItem(
                      icon: Icons.chat_bubble, label: 'Coach', route: '/coach'),
                  NavItem(
                      icon: Icons.insights,
                      label: 'Insights',
                      route: '/insights'),
                  NavItem(
                      icon: Icons.person, label: 'Profile', route: '/profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InsightsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Insights',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Share insights
            },
          ),
        ],
      ),
    );
  }
}

class _SleepInsights extends StatelessWidget {
  const _SleepInsights();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _WeeklySummaryCard(
            title: 'Sleep Quality',
            value: '7.2/10',
            change: '+0.5',
            trend: Trend.up,
          ),
          const SizedBox(height: 16),
          _AnimatedChart(
            title: 'Sleep Duration',
            chart: _buildSleepChart(),
          ),
          const SizedBox(height: 16),
          const _InsightCard(
            title: 'Sleep Pattern',
            description:
                'You sleep best when going to bed before 11 PM. Your average sleep quality increases by 15% on these nights.',
          ),
        ],
      ),
    );
  }

  Widget _buildSleepChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 7),
                const FlSpot(1, 7.5),
                const FlSpot(2, 6.5),
                const FlSpot(3, 8),
                const FlSpot(4, 7.5),
                const FlSpot(5, 8.5),
                const FlSpot(6, 7.2),
              ],
              isCurved: true,
              color: const Color(0xFF7B7CFF),
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF7B7CFF).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecoveryInsights extends StatelessWidget {
  const _RecoveryInsights();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _WeeklySummaryCard(
            title: 'Recovery Score',
            value: '85%',
            change: '+5%',
            trend: Trend.up,
          ),
          const SizedBox(height: 16),
          _AnimatedChart(
            title: 'HRV Trend',
            chart: _buildHRVChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildHRVChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 40),
                const FlSpot(1, 42),
                const FlSpot(2, 38),
                const FlSpot(3, 45),
                const FlSpot(4, 43),
                const FlSpot(5, 48),
                const FlSpot(6, 45),
              ],
              isCurved: true,
              color: const Color(0xFF6AE7C7),
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityInsights extends StatelessWidget {
  const _ActivityInsights();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WeeklySummaryCard(
            title: 'Activity Level',
            value: 'Active',
            change: '+12%',
            trend: Trend.up,
          ),
        ],
      ),
    );
  }
}

class _NutritionInsights extends StatelessWidget {
  const _NutritionInsights();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WeeklySummaryCard(
            title: 'Nutrition Score',
            value: 'Good',
            change: '+3%',
            trend: Trend.up,
          ),
        ],
      ),
    );
  }
}

class _WeeklySummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Trend trend;

  const _WeeklySummaryCard({
    required this.title,
    required this.value,
    required this.change,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: trend == Trend.up
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      trend == Trend.up
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 16,
                      color: trend == Trend.up ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      change,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: trend == Trend.up ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
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
}

class _AnimatedChart extends StatelessWidget {
  final String title;
  final Widget chart;

  const _AnimatedChart({
    required this.title,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          chart,
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String description;

  const _InsightCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

enum Trend { up, down, neutral }
