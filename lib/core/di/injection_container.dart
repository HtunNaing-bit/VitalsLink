import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/platform/healthkit_datasource.dart';
import '../../data/datasources/platform/google_fit_datasource.dart';
import '../../data/repositories/health_data_repository_impl.dart';
import '../../domain/repositories/health_data_repository.dart';
import 'dart:io';

/// Dependency Injection Container
/// Provides all repository instances and dependencies

// Platform Data Sources
final healthKitDataSourceProvider = Provider<HealthKitDataSource?>((ref) {
  if (Platform.isIOS) {
    return HealthKitDataSource();
  }
  return null;
});

final googleFitDataSourceProvider = Provider<GoogleFitDataSource?>((ref) {
  if (Platform.isAndroid) {
    return GoogleFitDataSource();
  }
  return null;
});

// Health Data Repository
final healthDataRepositoryProvider = Provider<HealthDataRepository>((ref) {
  final healthKit = ref.watch(healthKitDataSourceProvider);
  final googleFit = ref.watch(googleFitDataSourceProvider);
  
  return HealthDataRepositoryImpl(
    healthKitDataSource: healthKit,
    googleFitDataSource: googleFit,
  );
});

