import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole { member, family, clinician }

enum PrivacyLevel { standard, vault, clinician }

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String fullName,
    required UserRole role,
    required UserPreferences preferences,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required bool darkMode,
    required bool notificationsEnabled,
    required bool voiceCoachEnabled,
    required PrivacyLevel privacyLevel,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}
