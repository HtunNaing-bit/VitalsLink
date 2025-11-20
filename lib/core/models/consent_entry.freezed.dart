// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consent_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConsentEntry _$ConsentEntryFromJson(Map<String, dynamic> json) {
  return _ConsentEntry.fromJson(json);
}

/// @nodoc
mixin _$ConsentEntry {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  ConsentAction get action => throw _privateConstructorUsedError;
  ConsentScope get scope => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get signatureHash => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsentEntryCopyWith<ConsentEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsentEntryCopyWith<$Res> {
  factory $ConsentEntryCopyWith(
          ConsentEntry value, $Res Function(ConsentEntry) then) =
      _$ConsentEntryCopyWithImpl<$Res, ConsentEntry>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      ConsentAction action,
      ConsentScope scope,
      String? source,
      String? signatureHash,
      Map<String, dynamic>? metadata});

  $ConsentScopeCopyWith<$Res> get scope;
}

/// @nodoc
class _$ConsentEntryCopyWithImpl<$Res, $Val extends ConsentEntry>
    implements $ConsentEntryCopyWith<$Res> {
  _$ConsentEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? action = null,
    Object? scope = null,
    Object? source = freezed,
    Object? signatureHash = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ConsentAction,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as ConsentScope,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureHash: freezed == signatureHash
          ? _value.signatureHash
          : signatureHash // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConsentScopeCopyWith<$Res> get scope {
    return $ConsentScopeCopyWith<$Res>(_value.scope, (value) {
      return _then(_value.copyWith(scope: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConsentEntryImplCopyWith<$Res>
    implements $ConsentEntryCopyWith<$Res> {
  factory _$$ConsentEntryImplCopyWith(
          _$ConsentEntryImpl value, $Res Function(_$ConsentEntryImpl) then) =
      __$$ConsentEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      ConsentAction action,
      ConsentScope scope,
      String? source,
      String? signatureHash,
      Map<String, dynamic>? metadata});

  @override
  $ConsentScopeCopyWith<$Res> get scope;
}

/// @nodoc
class __$$ConsentEntryImplCopyWithImpl<$Res>
    extends _$ConsentEntryCopyWithImpl<$Res, _$ConsentEntryImpl>
    implements _$$ConsentEntryImplCopyWith<$Res> {
  __$$ConsentEntryImplCopyWithImpl(
      _$ConsentEntryImpl _value, $Res Function(_$ConsentEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? action = null,
    Object? scope = null,
    Object? source = freezed,
    Object? signatureHash = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ConsentEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as ConsentAction,
      scope: null == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as ConsentScope,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureHash: freezed == signatureHash
          ? _value.signatureHash
          : signatureHash // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsentEntryImpl implements _ConsentEntry {
  const _$ConsentEntryImpl(
      {required this.id,
      required this.userId,
      required this.timestamp,
      required this.action,
      required this.scope,
      this.source,
      this.signatureHash,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$ConsentEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsentEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime timestamp;
  @override
  final ConsentAction action;
  @override
  final ConsentScope scope;
  @override
  final String? source;
  @override
  final String? signatureHash;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ConsentEntry(id: $id, userId: $userId, timestamp: $timestamp, action: $action, scope: $scope, source: $source, signatureHash: $signatureHash, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsentEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.scope, scope) || other.scope == scope) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.signatureHash, signatureHash) ||
                other.signatureHash == signatureHash) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      timestamp,
      action,
      scope,
      source,
      signatureHash,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsentEntryImplCopyWith<_$ConsentEntryImpl> get copyWith =>
      __$$ConsentEntryImplCopyWithImpl<_$ConsentEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsentEntryImplToJson(
      this,
    );
  }
}

abstract class _ConsentEntry implements ConsentEntry {
  const factory _ConsentEntry(
      {required final String id,
      required final String userId,
      required final DateTime timestamp,
      required final ConsentAction action,
      required final ConsentScope scope,
      final String? source,
      final String? signatureHash,
      final Map<String, dynamic>? metadata}) = _$ConsentEntryImpl;

  factory _ConsentEntry.fromJson(Map<String, dynamic> json) =
      _$ConsentEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get timestamp;
  @override
  ConsentAction get action;
  @override
  ConsentScope get scope;
  @override
  String? get source;
  @override
  String? get signatureHash;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ConsentEntryImplCopyWith<_$ConsentEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsentScope _$ConsentScopeFromJson(Map<String, dynamic> json) {
  return _ConsentScope.fromJson(json);
}

/// @nodoc
mixin _$ConsentScope {
  List<String> get dataTypes =>
      throw _privateConstructorUsedError; // e.g., ['heart_rate', 'steps', 'sleep']
  List<String> get permissions =>
      throw _privateConstructorUsedError; // e.g., ['read', 'write', 'share']
  String? get provider =>
      throw _privateConstructorUsedError; // e.g., 'apple_health', 'fitbit'
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsentScopeCopyWith<ConsentScope> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsentScopeCopyWith<$Res> {
  factory $ConsentScopeCopyWith(
          ConsentScope value, $Res Function(ConsentScope) then) =
      _$ConsentScopeCopyWithImpl<$Res, ConsentScope>;
  @useResult
  $Res call(
      {List<String> dataTypes,
      List<String> permissions,
      String? provider,
      DateTime? expiresAt});
}

/// @nodoc
class _$ConsentScopeCopyWithImpl<$Res, $Val extends ConsentScope>
    implements $ConsentScopeCopyWith<$Res> {
  _$ConsentScopeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataTypes = null,
    Object? permissions = null,
    Object? provider = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      dataTypes: null == dataTypes
          ? _value.dataTypes
          : dataTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsentScopeImplCopyWith<$Res>
    implements $ConsentScopeCopyWith<$Res> {
  factory _$$ConsentScopeImplCopyWith(
          _$ConsentScopeImpl value, $Res Function(_$ConsentScopeImpl) then) =
      __$$ConsentScopeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> dataTypes,
      List<String> permissions,
      String? provider,
      DateTime? expiresAt});
}

/// @nodoc
class __$$ConsentScopeImplCopyWithImpl<$Res>
    extends _$ConsentScopeCopyWithImpl<$Res, _$ConsentScopeImpl>
    implements _$$ConsentScopeImplCopyWith<$Res> {
  __$$ConsentScopeImplCopyWithImpl(
      _$ConsentScopeImpl _value, $Res Function(_$ConsentScopeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataTypes = null,
    Object? permissions = null,
    Object? provider = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$ConsentScopeImpl(
      dataTypes: null == dataTypes
          ? _value._dataTypes
          : dataTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsentScopeImpl implements _ConsentScope {
  const _$ConsentScopeImpl(
      {required final List<String> dataTypes,
      required final List<String> permissions,
      this.provider,
      this.expiresAt})
      : _dataTypes = dataTypes,
        _permissions = permissions;

  factory _$ConsentScopeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsentScopeImplFromJson(json);

  final List<String> _dataTypes;
  @override
  List<String> get dataTypes {
    if (_dataTypes is EqualUnmodifiableListView) return _dataTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataTypes);
  }

// e.g., ['heart_rate', 'steps', 'sleep']
  final List<String> _permissions;
// e.g., ['heart_rate', 'steps', 'sleep']
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

// e.g., ['read', 'write', 'share']
  @override
  final String? provider;
// e.g., 'apple_health', 'fitbit'
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'ConsentScope(dataTypes: $dataTypes, permissions: $permissions, provider: $provider, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsentScopeImpl &&
            const DeepCollectionEquality()
                .equals(other._dataTypes, _dataTypes) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dataTypes),
      const DeepCollectionEquality().hash(_permissions),
      provider,
      expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsentScopeImplCopyWith<_$ConsentScopeImpl> get copyWith =>
      __$$ConsentScopeImplCopyWithImpl<_$ConsentScopeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsentScopeImplToJson(
      this,
    );
  }
}

abstract class _ConsentScope implements ConsentScope {
  const factory _ConsentScope(
      {required final List<String> dataTypes,
      required final List<String> permissions,
      final String? provider,
      final DateTime? expiresAt}) = _$ConsentScopeImpl;

  factory _ConsentScope.fromJson(Map<String, dynamic> json) =
      _$ConsentScopeImpl.fromJson;

  @override
  List<String> get dataTypes;
  @override // e.g., ['heart_rate', 'steps', 'sleep']
  List<String> get permissions;
  @override // e.g., ['read', 'write', 'share']
  String? get provider;
  @override // e.g., 'apple_health', 'fitbit'
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$ConsentScopeImplCopyWith<_$ConsentScopeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
