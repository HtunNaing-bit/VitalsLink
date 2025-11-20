import '../models/lab_result_model.dart';

/// Lab Data Service with Mock Data
class LabDataService {
  static final LabDataService _instance = LabDataService._internal();
  factory LabDataService() => _instance;
  LabDataService._internal();

  /// Get Lab Results (Mock)
  Future<List<LabResult>> getLabResults() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      LabResult(
        id: 'lab_001',
        biomarkerName: 'Total Cholesterol',
        value: 195.0,
        unit: 'mg/dL',
        referenceRange: '< 200 mg/dL',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        status: 'Normal',
      ),
      LabResult(
        id: 'lab_002',
        biomarkerName: 'Vitamin D',
        value: 28.0,
        unit: 'ng/mL',
        referenceRange: '30-100 ng/mL',
        timestamp: DateTime.now().subtract(const Duration(days: 14)),
        status: 'Low',
      ),
      LabResult(
        id: 'lab_003',
        biomarkerName: 'HbA1c',
        value: 5.4,
        unit: '%',
        referenceRange: '< 5.7%',
        timestamp: DateTime.now().subtract(const Duration(days: 30)),
        status: 'Normal',
      ),
      LabResult(
        id: 'lab_004',
        biomarkerName: 'Glucose',
        value: 95.0,
        unit: 'mg/dL',
        referenceRange: '70-100 mg/dL',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        status: 'Normal',
      ),
      LabResult(
        id: 'lab_005',
        biomarkerName: 'HDL Cholesterol',
        value: 65.0,
        unit: 'mg/dL',
        referenceRange: '> 40 mg/dL',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        status: 'Normal',
      ),
      LabResult(
        id: 'lab_006',
        biomarkerName: 'LDL Cholesterol',
        value: 120.0,
        unit: 'mg/dL',
        referenceRange: '< 100 mg/dL',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        status: 'High',
      ),
    ];
  }
}
