import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/glass_card.dart';
import '../../../utils/style_tokens.dart';
import '../../../services/scenario_service.dart';
import '../../../models/scenario_model.dart';

/// Scenario Planner Page for Prescriptive Digital Twinning
class ScenarioPlannerPage extends StatefulWidget {
  const ScenarioPlannerPage({super.key});

  @override
  State<ScenarioPlannerPage> createState() => _ScenarioPlannerPageState();
}

class _ScenarioPlannerPageState extends State<ScenarioPlannerPage> {
  final ScenarioService _scenarioService = ScenarioService();
  Scenario? _lastSimulation;
  bool _isRunning = false;

  Future<void> _runNewScenario() async {
    setState(() {
      _isRunning = true;
    });

    // Get an example scenario
    final exampleScenarios = _scenarioService.getExampleScenarios();
    final scenario = exampleScenarios.first;

    try {
      // Run simulation
      final result = await _scenarioService.runSimulation(scenario);

      setState(() {
        _lastSimulation = result;
        _isRunning = false;
      });
    } catch (e) {
      setState(() {
        _isRunning = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error running simulation: $e'),
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
          onPressed: () => context.go('/dashboard'),
        ),
        title: const Text('Scenario Planner'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(StyleTokens.spacing4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: StyleTokens.spacing4),
              // Header
              GlassCard(
                padding: const EdgeInsets.all(StyleTokens.spacing5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 32,
                          color: themeManager.currentTheme.primary,
                        ),
                        const SizedBox(width: StyleTokens.spacing3),
                        Expanded(
                          child: Text(
                            'What If?',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: StyleTokens.spacing3),
                    Text(
                      'Run predictive simulations to see how lifestyle changes might impact your health metrics.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: StyleTokens.getTextSecondaryStatic(
                                isDark: isDark),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: StyleTokens.spacing6),
              // Run New Scenario Button
              ElevatedButton.icon(
                onPressed: _isRunning ? null : _runNewScenario,
                icon: _isRunning
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(
                    _isRunning ? 'Running Simulation...' : 'Run New Scenario'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeManager.currentTheme.primary,
                  foregroundColor: themeManager.currentTheme.accentContrast,
                  padding: const EdgeInsets.symmetric(
                    vertical: StyleTokens.spacing5,
                    horizontal: StyleTokens.spacing6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(StyleTokens.radiusMedium),
                  ),
                ),
              ),
              // Results Section
              if (_lastSimulation != null) ...[
                const SizedBox(height: StyleTokens.spacing6),
                _buildResultsSection(
                    context, _lastSimulation!, themeManager, isDark),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsSection(
    BuildContext context,
    Scenario scenario,
    ThemeManager themeManager,
    bool isDark,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(StyleTokens.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(width: StyleTokens.spacing3),
              Expanded(
                child: Text(
                  scenario.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: StyleTokens.spacing4),
          // Actions
          Text(
            'Actions:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: StyleTokens.spacing2),
          ...scenario.actions.map((action) => Padding(
                padding: const EdgeInsets.only(bottom: StyleTokens.spacing2),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: themeManager.currentTheme.primary,
                    ),
                    const SizedBox(width: StyleTokens.spacing2),
                    Expanded(
                      child: Text(
                        action,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: StyleTokens.spacing4),
          const Divider(),
          const SizedBox(height: StyleTokens.spacing4),
          // Predicted Impact
          Text(
            'Predicted Impact:',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: StyleTokens.spacing3),
          ...scenario.predictedImpact.entries.map((entry) {
            final isPositive = entry.value > 0;
            final isNegative = entry.value < 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: StyleTokens.spacing3),
              child: Row(
                children: [
                  Icon(
                    isPositive
                        ? Icons.arrow_upward
                        : isNegative
                            ? Icons.arrow_downward
                            : Icons.remove,
                    color: isPositive
                        ? Colors.green
                        : isNegative
                            ? Colors.blue
                            : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: StyleTokens.spacing3),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    '${entry.value > 0 ? '+' : ''}${entry.value.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? Colors.green
                              : isNegative
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
