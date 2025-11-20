import '../core/models/ai_message.dart';
import '../core/models/health.dart';
import '../core/models/user.dart';

class MockData {
  static const AppUser mockUser = AppUser(
    id: 'user-001',
    email: 'jamie@vitalslink.app',
    fullName: 'Jamie Rivera',
    role: UserRole.member,
    preferences: UserPreferences(
      darkMode: true,
      notificationsEnabled: true,
      voiceCoachEnabled: false,
      privacyLevel: PrivacyLevel.vault,
    ),
  );

  static List<Connector> get connectors => const [
        Connector(
          id: 'fitbit',
          provider: 'Fitbit',
          description: 'Sync steps, HR, and sleep stages to VitalsLink.',
          connected: true,
        ),
        Connector(
          id: 'apple',
          provider: 'Apple Health',
          description:
              'Two-way sync for labs, mindfulness, and activity trends.',
          connected: true,
        ),
        Connector(
          id: 'oura',
          provider: 'Oura Ring',
          description: 'Nightly readiness, HRV, and temperature deltas.',
          connected: false,
        ),
        Connector(
          id: '23andme',
          provider: '23andMe',
          description: 'Import genetic markers and trait insights.',
          connected: false,
        ),
      ];

  static List<TimelineEvent> get timeline {
    final now = DateTime.now();
    return [
      TimelineEvent(
        id: 'event-1',
        title: 'AI Insight: Optimize Late Meals',
        description:
            'Suggested earlier dinner and chamomile tea to improve HRV trends.',
        timestamp: now.subtract(const Duration(hours: 1)),
        icon: '🤖',
      ),
      TimelineEvent(
        id: 'event-2',
        title: 'Sleep Goal Achieved',
        description: 'Achieved 7-day streak of consistent sleep schedule.',
        timestamp: now.subtract(const Duration(hours: 8)),
        icon: '🌙',
      ),
      TimelineEvent(
        id: 'event-3',
        title: 'Clinician Shared Report',
        description:
            'Family doctor reviewed lab results and added feedback to Privacy Vault.',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
        icon: '👩‍⚕️',
      ),
      TimelineEvent(
        id: 'event-4',
        title: 'Goal Reminder: Optimize Sleep',
        description:
            'AI recommends dimming lights at 9:45 PM and 10-minute breath work.',
        timestamp: now.subtract(const Duration(days: 2)),
        icon: '🛌',
      ),
    ];
  }

  static List<AIAction> get aiActions => const [
        AIAction(
          id: 'goal',
          title: 'Set Recovery Goal',
          description:
              'Create a focused recovery goal that adapts weekly to HRV + sleep trends.',
          command: '/goal',
        ),
        AIAction(
          id: 'trend',
          title: 'Review Predictive Trend',
          description:
              'View a 7-day HRV forecast with AI confidence intervals.',
          command: '/trend',
        ),
        AIAction(
          id: 'connect',
          title: 'Connect Wearables',
          description:
              'Link Oura or Whoop for micro-recovery analytics and badges.',
          command: '/connect',
        ),
      ];
}
