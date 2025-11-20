import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/health/health_metric_card.dart';
import '../../../domain/entities/health_data.dart';
import 'trends_page.dart';

/// Dashboard Page
/// Main screen displaying health metrics and trends
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VitalsLink'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Health Overview',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your health metrics at a glance',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              
              // Health Metric Cards Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  HealthMetricCard(
                    type: HealthMetricType.sleepDuration,
                    icon: Icons.bedtime,
                    color: Colors.blue,
                    label: 'Sleep',
                  ),
                  HealthMetricCard(
                    type: HealthMetricType.stepCount,
                    icon: Icons.directions_walk,
                    color: Colors.green,
                    label: 'Steps',
                  ),
                  HealthMetricCard(
                    type: HealthMetricType.heartRate,
                    icon: Icons.favorite,
                    color: Colors.red,
                    label: 'Heart Rate',
                  ),
                  HealthMetricCard(
                    type: HealthMetricType.mindfulnessMinutes,
                    icon: Icons.self_improvement,
                    color: Colors.purple,
                    label: 'Mindfulness',
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Section Title
              Text(
                '7-Day Trends',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              
              // Quick access to trends page
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrendsPage(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('View All Trends'),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

