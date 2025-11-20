import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
    Locale('my', 'MM')
  ];

  /// The application name
  ///
  /// In en, this message translates to:
  /// **'VitalsLink'**
  String get appName;

  /// The application tagline
  ///
  /// In en, this message translates to:
  /// **'AI Personal Health OS'**
  String get appTagline;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @coach.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get coach;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @onboarding.
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get onboarding;

  /// No description provided for @welcomeToVitalsLink.
  ///
  /// In en, this message translates to:
  /// **'Welcome to VitalsLink'**
  String get welcomeToVitalsLink;

  /// No description provided for @yourAIPoweredHealthCompanion.
  ///
  /// In en, this message translates to:
  /// **'Your AI-powered personal health companion'**
  String get yourAIPoweredHealthCompanion;

  /// No description provided for @personalizeYourExperience.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get personalizeYourExperience;

  /// No description provided for @tellUsAboutYourHealthGoals.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your health goals'**
  String get tellUsAboutYourHealthGoals;

  /// No description provided for @connectYourData.
  ///
  /// In en, this message translates to:
  /// **'Connect Your Data'**
  String get connectYourData;

  /// No description provided for @linkYourHealthAppsAndDevices.
  ///
  /// In en, this message translates to:
  /// **'Link your health apps and devices'**
  String get linkYourHealthAppsAndDevices;

  /// No description provided for @enablePermissions.
  ///
  /// In en, this message translates to:
  /// **'Enable Permissions'**
  String get enablePermissions;

  /// No description provided for @grantAccessToHealthData.
  ///
  /// In en, this message translates to:
  /// **'Grant access to health data'**
  String get grantAccessToHealthData;

  /// No description provided for @youreAllSet.
  ///
  /// In en, this message translates to:
  /// **'You\'re All Set!'**
  String get youreAllSet;

  /// No description provided for @letsStartYourHealthJourney.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start your health journey'**
  String get letsStartYourHealthJourney;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @sleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get sleep;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @stress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get stress;

  /// No description provided for @hrv.
  ///
  /// In en, this message translates to:
  /// **'HRV'**
  String get hrv;

  /// No description provided for @aiRecommendation.
  ///
  /// In en, this message translates to:
  /// **'AI Recommendation'**
  String get aiRecommendation;

  /// No description provided for @setGoal.
  ///
  /// In en, this message translates to:
  /// **'Set Goal'**
  String get setGoal;

  /// No description provided for @remindMe.
  ///
  /// In en, this message translates to:
  /// **'Remind Me'**
  String get remindMe;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @lastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced'**
  String get lastSynced;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @activeGoals.
  ///
  /// In en, this message translates to:
  /// **'Active Goals'**
  String get activeGoals;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @noGoalsYet.
  ///
  /// In en, this message translates to:
  /// **'No goals yet'**
  String get noGoalsYet;

  /// No description provided for @createYourFirstGoal.
  ///
  /// In en, this message translates to:
  /// **'Create your first goal to get started'**
  String get createYourFirstGoal;

  /// No description provided for @createGoal.
  ///
  /// In en, this message translates to:
  /// **'Create Goal'**
  String get createGoal;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @youreAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get youreAllCaughtUp;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @healthData.
  ///
  /// In en, this message translates to:
  /// **'Health Data'**
  String get healthData;

  /// No description provided for @readSleepActivityAndHeartRateData.
  ///
  /// In en, this message translates to:
  /// **'Read sleep, activity, and heart rate data'**
  String get readSleepActivityAndHeartRateData;

  /// No description provided for @notificationsPermission.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsPermission;

  /// No description provided for @receiveRemindersAndUpdates.
  ///
  /// In en, this message translates to:
  /// **'Receive reminders and updates'**
  String get receiveRemindersAndUpdates;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @trackLocationForActivityData.
  ///
  /// In en, this message translates to:
  /// **'Track location for activity data'**
  String get trackLocationForActivityData;

  /// No description provided for @whyWeNeedThis.
  ///
  /// In en, this message translates to:
  /// **'Why we need this:'**
  String get whyWeNeedThis;

  /// No description provided for @weReadSleepAndActivity.
  ///
  /// In en, this message translates to:
  /// **'We read Sleep & Activity to give personalized insights. You can revoke anytime.'**
  String get weReadSleepAndActivity;

  /// No description provided for @dataWeRead.
  ///
  /// In en, this message translates to:
  /// **'Data we read:'**
  String get dataWeRead;

  /// No description provided for @connectDataSources.
  ///
  /// In en, this message translates to:
  /// **'Connect Data Sources'**
  String get connectDataSources;

  /// No description provided for @dataHub.
  ///
  /// In en, this message translates to:
  /// **'Data Hub'**
  String get dataHub;

  /// No description provided for @sources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sources;

  /// No description provided for @vault.
  ///
  /// In en, this message translates to:
  /// **'Vault'**
  String get vault;

  /// No description provided for @connectedSources.
  ///
  /// In en, this message translates to:
  /// **'Connected Sources'**
  String get connectedSources;

  /// No description provided for @dataVault.
  ///
  /// In en, this message translates to:
  /// **'Data Vault'**
  String get dataVault;

  /// No description provided for @encryptedBackupsAndDataManagement.
  ///
  /// In en, this message translates to:
  /// **'Encrypted backups and data management'**
  String get encryptedBackupsAndDataManagement;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @createBackup.
  ///
  /// In en, this message translates to:
  /// **'Create Backup'**
  String get createBackup;

  /// No description provided for @createAnEncryptedBackup.
  ///
  /// In en, this message translates to:
  /// **'Create an encrypted backup'**
  String get createAnEncryptedBackup;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get restoreBackup;

  /// No description provided for @restoreFromABackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from a backup'**
  String get restoreFromABackup;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportYourDataAsJson.
  ///
  /// In en, this message translates to:
  /// **'Export your data as JSON'**
  String get exportYourDataAsJson;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAllData.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteAllData;

  /// No description provided for @permanentlyDeleteAllYourData.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete all your data'**
  String get permanentlyDeleteAllYourData;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @useDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Use dark theme'**
  String get useDarkTheme;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @reduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce Motion'**
  String get reduceMotion;

  /// No description provided for @disableAnimationsForBetterAccessibility.
  ///
  /// In en, this message translates to:
  /// **'Disable animations for better accessibility'**
  String get disableAnimationsForBetterAccessibility;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @helpUsImproveBySharingUsageData.
  ///
  /// In en, this message translates to:
  /// **'Help us improve by sharing usage data'**
  String get helpUsImproveBySharingUsageData;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @myanmar.
  ///
  /// In en, this message translates to:
  /// **'မြန်မာ (Myanmar)'**
  String get myanmar;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @areYouSureYouWantToDeleteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get areYouSureYouWantToDeleteYourAccount;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChat;

  /// No description provided for @care.
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get care;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood;

  /// No description provided for @great.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get great;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @notGreat.
  ///
  /// In en, this message translates to:
  /// **'Not Great'**
  String get notGreat;

  /// No description provided for @bad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get bad;

  /// No description provided for @howAreYouFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get howAreYouFeeling;

  /// No description provided for @journalEntry.
  ///
  /// In en, this message translates to:
  /// **'Journal Entry'**
  String get journalEntry;

  /// No description provided for @writeAboutYourDay.
  ///
  /// In en, this message translates to:
  /// **'Write about your day, thoughts, or feelings...'**
  String get writeAboutYourDay;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generating;

  /// No description provided for @generateAISummary.
  ///
  /// In en, this message translates to:
  /// **'Generate AI Summary'**
  String get generateAISummary;

  /// No description provided for @aiSummary.
  ///
  /// In en, this message translates to:
  /// **'AI Summary'**
  String get aiSummary;

  /// No description provided for @askVitalsLink.
  ///
  /// In en, this message translates to:
  /// **'Ask VitalsLink'**
  String get askVitalsLink;

  /// No description provided for @voiceToTextComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Voice-to-text coming soon'**
  String get voiceToTextComingSoon;

  /// No description provided for @sorryIEncounteredAnError.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I encountered an error. Please try again.'**
  String get sorryIEncounteredAnError;

  /// No description provided for @helloImVitalsLink.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m VitalsLink, your AI health co-pilot. How can I help you today?'**
  String get helloImVitalsLink;

  /// No description provided for @scenarioPlanner.
  ///
  /// In en, this message translates to:
  /// **'Scenario Planner: What If?'**
  String get scenarioPlanner;

  /// No description provided for @scenarioPlannerDescription.
  ///
  /// In en, this message translates to:
  /// **'Run predictive simulations to see how lifestyle changes might impact your health metrics.'**
  String get scenarioPlannerDescription;

  /// No description provided for @correlative.
  ///
  /// In en, this message translates to:
  /// **'CORRELATIVE'**
  String get correlative;

  /// No description provided for @confidence.
  ///
  /// In en, this message translates to:
  /// **'confidence'**
  String get confidence;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @howThisInsightWasGenerated.
  ///
  /// In en, this message translates to:
  /// **'How This Insight Was Generated'**
  String get howThisInsightWasGenerated;

  /// No description provided for @dataSources.
  ///
  /// In en, this message translates to:
  /// **'Data Sources:'**
  String get dataSources;

  /// No description provided for @yourDataIsProcessedLocally.
  ///
  /// In en, this message translates to:
  /// **'Your data is processed locally and never shared without your explicit consent.'**
  String get yourDataIsProcessedLocally;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @careHub.
  ///
  /// In en, this message translates to:
  /// **'Care Hub'**
  String get careHub;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @labResults.
  ///
  /// In en, this message translates to:
  /// **'Lab Results'**
  String get labResults;

  /// No description provided for @noProvidersAvailable.
  ///
  /// In en, this message translates to:
  /// **'No providers available'**
  String get noProvidersAvailable;

  /// No description provided for @bookConsultation.
  ///
  /// In en, this message translates to:
  /// **'Book Consultation'**
  String get bookConsultation;

  /// No description provided for @bookAConsultationWith.
  ///
  /// In en, this message translates to:
  /// **'Book a consultation with {doctor}?'**
  String bookAConsultationWith(String doctor);

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @viewLabResults.
  ///
  /// In en, this message translates to:
  /// **'View Lab Results'**
  String get viewLabResults;

  /// No description provided for @accessYourLabTestResults.
  ///
  /// In en, this message translates to:
  /// **'Access your lab test results and track biomarkers over time'**
  String get accessYourLabTestResults;

  /// No description provided for @errorBookingConsultation.
  ///
  /// In en, this message translates to:
  /// **'Error booking consultation: {error}'**
  String errorBookingConsultation(String error);

  /// No description provided for @consultationBookedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Consultation booked successfully!'**
  String get consultationBookedSuccessfully;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviewsCount(int count);

  /// No description provided for @reviewsAndReflection.
  ///
  /// In en, this message translates to:
  /// **'Reviews & Reflection'**
  String get reviewsAndReflection;

  /// No description provided for @allReviews.
  ///
  /// In en, this message translates to:
  /// **'All Reviews'**
  String get allReviews;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @aiInsights.
  ///
  /// In en, this message translates to:
  /// **'AI Insights'**
  String get aiInsights;

  /// No description provided for @anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'my':
      {
        switch (locale.countryCode) {
          case 'MM':
            return AppLocalizationsMyMm();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
