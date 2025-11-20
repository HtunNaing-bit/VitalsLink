import 'package:freezed_annotation/freezed_annotation.dart';

part 'consent_entry.freezed.dart';
part 'consent_entry.g.dart';

/// Consent ledger entry - immutable record of user consent actions
@freezed
class ConsentEntry with _$ConsentEntry {
  const factory ConsentEntry({
    required String id,
    required String userId,
    required DateTime timestamp,
    required ConsentAction action,
    required ConsentScope scope,
    String? source,
    String? signatureHash,
    Map<String, dynamic>? metadata,
  }) = _ConsentEntry;

  factory ConsentEntry.fromJson(Map<String, dynamic> json) =>
      _$ConsentEntryFromJson(json);
}

/// Consent action types
enum ConsentAction {
  granted,
  revoked,
  exported,
  shared,
  deleted,
}

/// Consent scope - what data/permissions are covered
@freezed
class ConsentScope with _$ConsentScope {
  const factory ConsentScope({
    required List<String> dataTypes, // e.g., ['heart_rate', 'steps', 'sleep']
    required List<String> permissions, // e.g., ['read', 'write', 'share']
    String? provider, // e.g., 'apple_health', 'fitbit'
    DateTime? expiresAt,
  }) = _ConsentScope;

  factory ConsentScope.fromJson(Map<String, dynamic> json) =>
      _$ConsentScopeFromJson(json);
}
