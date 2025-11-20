// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      preferences:
          UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'role': _$UserRoleEnumMap[instance.role]!,
      'preferences': instance.preferences,
    };

const _$UserRoleEnumMap = {
  UserRole.member: 'member',
  UserRole.family: 'family',
  UserRole.clinician: 'clinician',
};

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      darkMode: json['darkMode'] as bool,
      notificationsEnabled: json['notificationsEnabled'] as bool,
      voiceCoachEnabled: json['voiceCoachEnabled'] as bool,
      privacyLevel: $enumDecode(_$PrivacyLevelEnumMap, json['privacyLevel']),
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'notificationsEnabled': instance.notificationsEnabled,
      'voiceCoachEnabled': instance.voiceCoachEnabled,
      'privacyLevel': _$PrivacyLevelEnumMap[instance.privacyLevel]!,
    };

const _$PrivacyLevelEnumMap = {
  PrivacyLevel.standard: 'standard',
  PrivacyLevel.vault: 'vault',
  PrivacyLevel.clinician: 'clinician',
};
