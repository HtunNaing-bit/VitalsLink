import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'ui/pages/onboarding/onboarding_welcome.dart';
import 'ui/pages/onboarding/onboarding_connect.dart';
import 'ui/pages/onboarding/onboarding_personalize.dart';
import 'ui/pages/dashboard/dashboard_screen.dart';
import 'ui/pages/journal/journal_screen.dart';
import 'ui/pages/ai_chat/ai_chat_screen.dart';
import 'ui/pages/care/care_screen.dart';
import 'ui/pages/care/lab_results_page.dart';
import 'ui/pages/care/provider_portal_view_page.dart';
import 'ui/pages/reviews/reviews_screen.dart';
import 'ui/pages/profile/share_with_provider_page.dart';
import 'ui/pages/profile/rewards_page.dart';
import 'ui/pages/dashboard/scenario_planner_page.dart';
import '../../../features/profile/screens/profile_settings.dart';
import '../../../features/notifications/screens/notifications_screen.dart';

/// App Routes Configuration
final appRoutes = GoRouter(
  initialLocation: '/onboarding/welcome',
  routes: [
    // Onboarding Routes (3 pages)
    GoRoute(
      path: '/onboarding/welcome',
      name: 'onboarding_welcome',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const OnboardingWelcomeScreen(),
      ),
    ),
    GoRoute(
      path: '/onboarding/connect',
      name: 'onboarding_connect',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const OnboardingConnectScreen(),
      ),
    ),
    GoRoute(
      path: '/onboarding/personalize',
      name: 'onboarding_personalize',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const OnboardingPersonalizeScreen(),
      ),
    ),
    // Main App Routes
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const DashboardScreen(),
      ),
    ),
    GoRoute(
      path: '/journal',
      name: 'journal',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const JournalScreen(),
      ),
    ),
    GoRoute(
      path: '/ai-chat',
      name: 'ai_chat',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const AIChatScreen(),
      ),
    ),
    GoRoute(
      path: '/care',
      name: 'care',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CareScreen(),
      ),
    ),
    GoRoute(
      path: '/reviews',
      name: 'reviews',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ReviewsScreen(),
      ),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ProfileSettings(),
      ),
    ),
    GoRoute(
      path: '/care/lab-results',
      name: 'lab_results',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LabResultsPage(),
      ),
    ),
    GoRoute(
      path: '/profile/share-with-provider',
      name: 'share_with_provider',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ShareWithProviderPage(),
      ),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: '/dashboard/scenario-planner',
      name: 'scenario_planner',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ScenarioPlannerPage(),
      ),
    ),
    GoRoute(
      path: '/profile/rewards',
      name: 'rewards',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const RewardsPage(),
      ),
    ),
    GoRoute(
      path: '/care/provider-portal',
      name: 'provider_portal',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ProviderPortalViewPage(),
      ),
    ),
  ],
);
