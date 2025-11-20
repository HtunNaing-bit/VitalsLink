import 'package:flutter/material.dart';

/// Lab Status Enum
enum LabStatus {
  normal,
  high,
  low,
}

/// Lab Result Model
class LabResult {
  final String id;
  final String biomarkerName;
  final double value;
  final String unit;
  final String referenceRange;
  final DateTime timestamp;
  final String status; // 'Normal', 'High', 'Low'

  LabResult({
    required this.id,
    required this.biomarkerName,
    required this.value,
    required this.unit,
    required this.referenceRange,
    required this.timestamp,
    required this.status,
  });

  /// Get LabStatus from string
  LabStatus get labStatus {
    switch (status.toLowerCase()) {
      case 'normal':
        return LabStatus.normal;
      case 'high':
        return LabStatus.high;
      case 'low':
        return LabStatus.low;
      default:
        return LabStatus.normal;
    }
  }

  /// Static utility method to get status icon
  static IconData getStatusIcon(LabStatus status) {
    switch (status) {
      case LabStatus.normal:
        return Icons.check;
      case LabStatus.high:
        return Icons.arrow_upward;
      case LabStatus.low:
        return Icons.arrow_downward;
    }
  }
}
