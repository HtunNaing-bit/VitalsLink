// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return _Metric.fromJson(json);
}

/// @nodoc
mixin _$Metric {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  MetricType get type => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetricCopyWith<Metric> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetricCopyWith<$Res> {
  factory $MetricCopyWith(Metric value, $Res Function(Metric) then) =
      _$MetricCopyWithImpl<$Res, Metric>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      MetricType type,
      double value,
      String sourceId,
      String? unit,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$MetricCopyWithImpl<$Res, $Val extends Metric>
    implements $MetricCopyWith<$Res> {
  _$MetricCopyWithImpl(this._value, this._then);

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
    Object? type = null,
    Object? value = null,
    Object? sourceId = null,
    Object? unit = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MetricType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetricImplCopyWith<$Res> implements $MetricCopyWith<$Res> {
  factory _$$MetricImplCopyWith(
          _$MetricImpl value, $Res Function(_$MetricImpl) then) =
      __$$MetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime timestamp,
      MetricType type,
      double value,
      String sourceId,
      String? unit,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$MetricImplCopyWithImpl<$Res>
    extends _$MetricCopyWithImpl<$Res, _$MetricImpl>
    implements _$$MetricImplCopyWith<$Res> {
  __$$MetricImplCopyWithImpl(
      _$MetricImpl _value, $Res Function(_$MetricImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? type = null,
    Object? value = null,
    Object? sourceId = null,
    Object? unit = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$MetricImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MetricType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      sourceId: null == sourceId
          ? _value.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as String,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
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
class _$MetricImpl implements _Metric {
  const _$MetricImpl(
      {required this.id,
      required this.userId,
      required this.timestamp,
      required this.type,
      required this.value,
      required this.sourceId,
      this.unit,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$MetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetricImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime timestamp;
  @override
  final MetricType type;
  @override
  final double value;
  @override
  final String sourceId;
  @override
  final String? unit;
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
    return 'Metric(id: $id, userId: $userId, timestamp: $timestamp, type: $type, value: $value, sourceId: $sourceId, unit: $unit, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetricImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, timestamp, type,
      value, sourceId, unit, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MetricImplCopyWith<_$MetricImpl> get copyWith =>
      __$$MetricImplCopyWithImpl<_$MetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetricImplToJson(
      this,
    );
  }
}

abstract class _Metric implements Metric {
  const factory _Metric(
      {required final String id,
      required final String userId,
      required final DateTime timestamp,
      required final MetricType type,
      required final double value,
      required final String sourceId,
      final String? unit,
      final Map<String, dynamic>? metadata}) = _$MetricImpl;

  factory _Metric.fromJson(Map<String, dynamic> json) = _$MetricImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get timestamp;
  @override
  MetricType get type;
  @override
  double get value;
  @override
  String get sourceId;
  @override
  String? get unit;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$MetricImplCopyWith<_$MetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DataSource _$DataSourceFromJson(Map<String, dynamic> json) {
  return _DataSource.fromJson(json);
}

/// @nodoc
mixin _$DataSource {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get provider =>
      throw _privateConstructorUsedError; // e.g., 'apple_health', 'fitbit', 'google_fit'
  DataSourceStatus get status => throw _privateConstructorUsedError;
  DateTime? get lastSync => throw _privateConstructorUsedError;
  Map<String, dynamic>? get config => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataSourceCopyWith<DataSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSourceCopyWith<$Res> {
  factory $DataSourceCopyWith(
          DataSource value, $Res Function(DataSource) then) =
      _$DataSourceCopyWithImpl<$Res, DataSource>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String provider,
      DataSourceStatus status,
      DateTime? lastSync,
      Map<String, dynamic>? config});
}

/// @nodoc
class _$DataSourceCopyWithImpl<$Res, $Val extends DataSource>
    implements $DataSourceCopyWith<$Res> {
  _$DataSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? provider = null,
    Object? status = null,
    Object? lastSync = freezed,
    Object? config = freezed,
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
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DataSourceStatus,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      config: freezed == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataSourceImplCopyWith<$Res>
    implements $DataSourceCopyWith<$Res> {
  factory _$$DataSourceImplCopyWith(
          _$DataSourceImpl value, $Res Function(_$DataSourceImpl) then) =
      __$$DataSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String provider,
      DataSourceStatus status,
      DateTime? lastSync,
      Map<String, dynamic>? config});
}

/// @nodoc
class __$$DataSourceImplCopyWithImpl<$Res>
    extends _$DataSourceCopyWithImpl<$Res, _$DataSourceImpl>
    implements _$$DataSourceImplCopyWith<$Res> {
  __$$DataSourceImplCopyWithImpl(
      _$DataSourceImpl _value, $Res Function(_$DataSourceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? provider = null,
    Object? status = null,
    Object? lastSync = freezed,
    Object? config = freezed,
  }) {
    return _then(_$DataSourceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DataSourceStatus,
      lastSync: freezed == lastSync
          ? _value.lastSync
          : lastSync // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      config: freezed == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataSourceImpl implements _DataSource {
  const _$DataSourceImpl(
      {required this.id,
      required this.userId,
      required this.provider,
      required this.status,
      this.lastSync,
      final Map<String, dynamic>? config})
      : _config = config;

  factory _$DataSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataSourceImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String provider;
// e.g., 'apple_health', 'fitbit', 'google_fit'
  @override
  final DataSourceStatus status;
  @override
  final DateTime? lastSync;
  final Map<String, dynamic>? _config;
  @override
  Map<String, dynamic>? get config {
    final value = _config;
    if (value == null) return null;
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'DataSource(id: $id, userId: $userId, provider: $provider, status: $status, lastSync: $lastSync, config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataSourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.lastSync, lastSync) ||
                other.lastSync == lastSync) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, provider, status,
      lastSync, const DeepCollectionEquality().hash(_config));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      __$$DataSourceImplCopyWithImpl<_$DataSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataSourceImplToJson(
      this,
    );
  }
}

abstract class _DataSource implements DataSource {
  const factory _DataSource(
      {required final String id,
      required final String userId,
      required final String provider,
      required final DataSourceStatus status,
      final DateTime? lastSync,
      final Map<String, dynamic>? config}) = _$DataSourceImpl;

  factory _DataSource.fromJson(Map<String, dynamic> json) =
      _$DataSourceImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get provider;
  @override // e.g., 'apple_health', 'fitbit', 'google_fit'
  DataSourceStatus get status;
  @override
  DateTime? get lastSync;
  @override
  Map<String, dynamic>? get config;
  @override
  @JsonKey(ignore: true)
  _$$DataSourceImplCopyWith<_$DataSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
