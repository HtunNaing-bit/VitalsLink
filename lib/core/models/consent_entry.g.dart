// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsentEntryImpl _$$ConsentEntryImplFromJson(Map<String, dynamic> json) =>
    _$ConsentEntryImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      action: $enumDecode(_$ConsentActionEnumMap, json['action']),
      scope: ConsentScope.fromJson(json['scope'] as Map<String, dynamic>),
      source: json['source'] as String?,
      signatureHash: json['signatureHash'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ConsentEntryImplToJson(_$ConsentEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'timestamp': instance.timestamp.toIso8601String(),
      'action': _$ConsentActionEnumMap[instance.action]!,
      'scope': instance.scope,
      'source': instance.source,
      'signatureHash': instance.signatureHash,
      'metadata': instance.metadata,
    };

const _$ConsentActionEnumMap = {
  ConsentAction.granted: 'granted',
  ConsentAction.revoked: 'revoked',
  ConsentAction.exported: 'exported',
  ConsentAction.shared: 'shared',
  ConsentAction.deleted: 'deleted',
};

_$ConsentScopeImpl _$$ConsentScopeImplFromJson(Map<String, dynamic> json) =>
    _$ConsentScopeImpl(
      dataTypes:
          (json['dataTypes'] as List<dynamic>).map((e) => e as String).toList(),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      provider: json['provider'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$ConsentScopeImplToJson(_$ConsentScopeImpl instance) =>
    <String, dynamic>{
      'dataTypes': instance.dataTypes,
      'permissions': instance.permissions,
      'provider': instance.provider,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
