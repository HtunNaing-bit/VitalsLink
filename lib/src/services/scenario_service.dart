import '../models/scenario_model.dart';

/// Scenario Service for Prescriptive Digital Twinning
class ScenarioService {
  static final ScenarioService _instance = ScenarioService._internal();
  factory ScenarioService() => _instance;
  ScenarioService._internal();

  /// Run a scenario simulation (Mock)
  Future<Scenario> runSimulation(Scenario scenario) async {
    // Simulate complex AI processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Return mock scenario with positive predicted impact
    return scenario.copyWith(
      predictedImpact: {
        'HbA1c': -0.3,
        'Energy Score': 15.0,
        'Sleep Quality': 12.0,
        'Resting Heart Rate': -3.0,
        'HRV': 8.0,
        'Weight (lbs)': -2.5,
        'Blood Pressure (Systolic)': -5.0,
      },
    );
  }

  /// Get example scenarios
  List<Scenario> getExampleScenarios() {
    return [
      Scenario(
        id: 'scenario_1',
        name: 'Keto Diet Simulation',
        actions: [
          '+30 min daily sleep',
          'Cut out all processed sugar',
          'Increase healthy fats intake',
          'Reduce carbs to <20g/day',
        ],
        predictedImpact: {},
        creationDate: DateTime.now(),
      ),
      Scenario(
        id: 'scenario_2',
        name: 'Mediterranean Lifestyle',
        actions: [
          'Add 2 servings of fish per week',
          'Increase olive oil consumption',
          'Daily 30-min walk',
          'Reduce red meat to 1x/week',
        ],
        predictedImpact: {},
        creationDate: DateTime.now(),
      ),
      Scenario(
        id: 'scenario_3',
        name: 'Sleep Optimization',
        actions: [
          'Bedtime at 10 PM consistently',
          'No screens 1 hour before bed',
          'Room temperature at 65°F',
          'Morning sunlight exposure',
        ],
        predictedImpact: {},
        creationDate: DateTime.now(),
      ),
    ];
  }
}
