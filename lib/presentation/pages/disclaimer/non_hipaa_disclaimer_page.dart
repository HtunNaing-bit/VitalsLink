import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Non-HIPAA Critical Disclaimer Page
/// Displays disclaimer about data handling and privacy
class NonHIPAADisclaimerPage extends ConsumerStatefulWidget {
  const NonHIPAADisclaimerPage({super.key});

  @override
  ConsumerState<NonHIPAADisclaimerPage> createState() => _NonHIPAADisclaimerPageState();
}

class _NonHIPAADisclaimerPageState extends ConsumerState<NonHIPAADisclaimerPage> {
  bool _hasAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Data Disclaimer'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Important Information',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),

              // Disclaimer Content
              _buildSection(
                context,
                'Data Collection',
                'VitalsLink collects health data from your device (HealthKit/Google Fit) including sleep duration, step count, heart rate, and mindfulness minutes. This data is processed locally on your device and may be synced to secure cloud storage for backup and analysis purposes.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                context,
                'Non-HIPAA Status',
                'VitalsLink is NOT a HIPAA-covered entity. This means:\n\n'
                    '• We are not a healthcare provider\n'
                    '• We do not provide medical advice\n'
                    '• Your data is not considered Protected Health Information (PHI)\n'
                    '• We do not have Business Associate Agreements (BAAs) with healthcare providers',
              ),
              const SizedBox(height: 20),

              _buildSection(
                context,
                'Data Usage',
                'Your health data is used to:\n\n'
                    '• Provide personalized health insights\n'
                    '• Generate AI-powered recommendations\n'
                    '• Track trends and patterns over time\n'
                    '• Improve our services\n\n'
                    'We do NOT sell your personal health data to third parties.',
              ),
              const SizedBox(height: 20),

              _buildSection(
                context,
                'Data Security',
                'We implement industry-standard security measures:\n\n'
                    '• End-to-end encryption for data in transit\n'
                    '• Encryption at rest for stored data\n'
                    '• Secure token storage on your device\n'
                    '• Regular security audits\n'
                    '• Access controls and authentication',
              ),
              const SizedBox(height: 20),

              _buildSection(
                context,
                'Your Rights',
                'You have the right to:\n\n'
                    '• Access your data at any time\n'
                    '• Export your data in a portable format\n'
                    '• Delete your account and all associated data\n'
                    '• Opt out of data collection (with limited functionality)\n'
                    '• Request data correction',
              ),
              const SizedBox(height: 20),

              _buildSection(
                context,
                'Limitations',
                'VitalsLink is designed for wellness and lifestyle tracking, not medical diagnosis or treatment. Always consult with healthcare professionals for medical advice.',
              ),
              const SizedBox(height: 32),

              // Acceptance Checkbox
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: CheckboxListTile(
                  value: _hasAccepted,
                  onChanged: (value) {
                    setState(() {
                      _hasAccepted = value ?? false;
                    });
                  },
                  title: const Text(
                    'I understand and accept these terms',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                    'By accepting, you acknowledge that you have read and understood this disclaimer.',
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigate back or exit app
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          // Exit app if can't go back
                        }
                      },
                      child: const Text('Decline'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _hasAccepted
                          ? () {
                              // Save acceptance to secure storage
                              // Navigate to main app
                              // TODO: Save to secure storage
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                // Navigate to dashboard
                                context.go('/dashboard');
                              }
                            }
                          : null,
                      child: const Text('Accept & Continue'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

