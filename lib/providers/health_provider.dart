import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:health/health.dart';  // Temporarily disabled due to dependency conflict

import '../core/models/health.dart';
import '../core/services/health_service.dart';
import '../mocks/mock_data.dart';

final healthServiceProvider = Provider<HealthService>((ref) => HealthService());

final dashboardSnapshotProvider = FutureProvider<DashboardSnapshot>((
  ref,
) async {
  final service = ref.watch(healthServiceProvider);
  // Request permissions with health data types (disabled - using mock data)
  await service.requestPermissions(types: [
    'HEART_RATE', // Changed from HealthDataType
    'STEPS', // Changed from HealthDataType
    'SLEEP_IN_BED', // Changed from HealthDataType
  ]);
  final metrics = await service.fetchMetrics();
  final trend = await service.fetchTrend();
  final forecast = await service.fetchForecast();
  final timeline = await service.fetchTimeline();
  return DashboardSnapshot(
    metrics: metrics,
    trend: trend,
    forecast: forecast,
    timeline: timeline,
    insight:
        'HRV ↓ 12% after late meals. AI suggests earlier dinners and light mobility to restore balance.',
  );
});

final connectorsProvider = Provider<List<Connector>>(
  (ref) => MockData.connectors,
);

final timelineProvider = Provider<List<TimelineEvent>>(
  (ref) => MockData.timeline,
);
