// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthMetric _$HealthMetricFromJson(Map<String, dynamic> json) {
  return _HealthMetric.fromJson(json);
}

/// @nodoc
mixin _$HealthMetric {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get delta => throw _privateConstructorUsedError;
  String? get insight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthMetricCopyWith<HealthMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthMetricCopyWith<$Res> {
  factory $HealthMetricCopyWith(
          HealthMetric value, $Res Function(HealthMetric) then) =
      _$HealthMetricCopyWithImpl<$Res, HealthMetric>;
  @useResult
  $Res call(
      {String id, String label, String value, String? delta, String? insight});
}

/// @nodoc
class _$HealthMetricCopyWithImpl<$Res, $Val extends HealthMetric>
    implements $HealthMetricCopyWith<$Res> {
  _$HealthMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? value = null,
    Object? delta = freezed,
    Object? insight = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      delta: freezed == delta
          ? _value.delta
          : delta // ignore: cast_nullable_to_non_nullable
              as String?,
      insight: freezed == insight
          ? _value.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthMetricImplCopyWith<$Res>
    implements $HealthMetricCopyWith<$Res> {
  factory _$$HealthMetricImplCopyWith(
          _$HealthMetricImpl value, $Res Function(_$HealthMetricImpl) then) =
      __$$HealthMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String label, String value, String? delta, String? insight});
}

/// @nodoc
class __$$HealthMetricImplCopyWithImpl<$Res>
    extends _$HealthMetricCopyWithImpl<$Res, _$HealthMetricImpl>
    implements _$$HealthMetricImplCopyWith<$Res> {
  __$$HealthMetricImplCopyWithImpl(
      _$HealthMetricImpl _value, $Res Function(_$HealthMetricImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? value = null,
    Object? delta = freezed,
    Object? insight = freezed,
  }) {
    return _then(_$HealthMetricImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      delta: freezed == delta
          ? _value.delta
          : delta // ignore: cast_nullable_to_non_nullable
              as String?,
      insight: freezed == insight
          ? _value.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthMetricImpl implements _HealthMetric {
  const _$HealthMetricImpl(
      {required this.id,
      required this.label,
      required this.value,
      this.delta,
      this.insight});

  factory _$HealthMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthMetricImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String value;
  @override
  final String? delta;
  @override
  final String? insight;

  @override
  String toString() {
    return 'HealthMetric(id: $id, label: $label, value: $value, delta: $delta, insight: $insight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthMetricImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.delta, delta) || other.delta == delta) &&
            (identical(other.insight, insight) || other.insight == insight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, value, delta, insight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthMetricImplCopyWith<_$HealthMetricImpl> get copyWith =>
      __$$HealthMetricImplCopyWithImpl<_$HealthMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthMetricImplToJson(
      this,
    );
  }
}

abstract class _HealthMetric implements HealthMetric {
  const factory _HealthMetric(
      {required final String id,
      required final String label,
      required final String value,
      final String? delta,
      final String? insight}) = _$HealthMetricImpl;

  factory _HealthMetric.fromJson(Map<String, dynamic> json) =
      _$HealthMetricImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get value;
  @override
  String? get delta;
  @override
  String? get insight;
  @override
  @JsonKey(ignore: true)
  _$$HealthMetricImplCopyWith<_$HealthMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendPoint _$TrendPointFromJson(Map<String, dynamic> json) {
  return _TrendPoint.fromJson(json);
}

/// @nodoc
mixin _$TrendPoint {
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrendPointCopyWith<TrendPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendPointCopyWith<$Res> {
  factory $TrendPointCopyWith(
          TrendPoint value, $Res Function(TrendPoint) then) =
      _$TrendPointCopyWithImpl<$Res, TrendPoint>;
  @useResult
  $Res call({DateTime timestamp, double value});
}

/// @nodoc
class _$TrendPointCopyWithImpl<$Res, $Val extends TrendPoint>
    implements $TrendPointCopyWith<$Res> {
  _$TrendPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendPointImplCopyWith<$Res>
    implements $TrendPointCopyWith<$Res> {
  factory _$$TrendPointImplCopyWith(
          _$TrendPointImpl value, $Res Function(_$TrendPointImpl) then) =
      __$$TrendPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime timestamp, double value});
}

/// @nodoc
class __$$TrendPointImplCopyWithImpl<$Res>
    extends _$TrendPointCopyWithImpl<$Res, _$TrendPointImpl>
    implements _$$TrendPointImplCopyWith<$Res> {
  __$$TrendPointImplCopyWithImpl(
      _$TrendPointImpl _value, $Res Function(_$TrendPointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? value = null,
  }) {
    return _then(_$TrendPointImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendPointImpl implements _TrendPoint {
  const _$TrendPointImpl({required this.timestamp, required this.value});

  factory _$TrendPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendPointImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final double value;

  @override
  String toString() {
    return 'TrendPoint(timestamp: $timestamp, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendPointImplCopyWith<_$TrendPointImpl> get copyWith =>
      __$$TrendPointImplCopyWithImpl<_$TrendPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendPointImplToJson(
      this,
    );
  }
}

abstract class _TrendPoint implements TrendPoint {
  const factory _TrendPoint(
      {required final DateTime timestamp,
      required final double value}) = _$TrendPointImpl;

  factory _TrendPoint.fromJson(Map<String, dynamic> json) =
      _$TrendPointImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$TrendPointImplCopyWith<_$TrendPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) {
  return _TimelineEvent.fromJson(json);
}

/// @nodoc
mixin _$TimelineEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimelineEventCopyWith<TimelineEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime timestamp,
      String? icon});
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? timestamp = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineEventImplCopyWith<$Res>
    implements $TimelineEventCopyWith<$Res> {
  factory _$$TimelineEventImplCopyWith(
          _$TimelineEventImpl value, $Res Function(_$TimelineEventImpl) then) =
      __$$TimelineEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime timestamp,
      String? icon});
}

/// @nodoc
class __$$TimelineEventImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$TimelineEventImpl>
    implements _$$TimelineEventImplCopyWith<$Res> {
  __$$TimelineEventImplCopyWithImpl(
      _$TimelineEventImpl _value, $Res Function(_$TimelineEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? timestamp = null,
    Object? icon = freezed,
  }) {
    return _then(_$TimelineEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineEventImpl implements _TimelineEvent {
  const _$TimelineEventImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.timestamp,
      this.icon});

  factory _$TimelineEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineEventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime timestamp;
  @override
  final String? icon;

  @override
  String toString() {
    return 'TimelineEvent(id: $id, title: $title, description: $description, timestamp: $timestamp, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, timestamp, icon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      __$$TimelineEventImplCopyWithImpl<_$TimelineEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineEventImplToJson(
      this,
    );
  }
}

abstract class _TimelineEvent implements TimelineEvent {
  const factory _TimelineEvent(
      {required final String id,
      required final String title,
      required final String description,
      required final DateTime timestamp,
      final String? icon}) = _$TimelineEventImpl;

  factory _TimelineEvent.fromJson(Map<String, dynamic> json) =
      _$TimelineEventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get timestamp;
  @override
  String? get icon;
  @override
  @JsonKey(ignore: true)
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Connector _$ConnectorFromJson(Map<String, dynamic> json) {
  return _Connector.fromJson(json);
}

/// @nodoc
mixin _$Connector {
  String get id => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get connected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectorCopyWith<Connector> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectorCopyWith<$Res> {
  factory $ConnectorCopyWith(Connector value, $Res Function(Connector) then) =
      _$ConnectorCopyWithImpl<$Res, Connector>;
  @useResult
  $Res call({String id, String provider, String description, bool connected});
}

/// @nodoc
class _$ConnectorCopyWithImpl<$Res, $Val extends Connector>
    implements $ConnectorCopyWith<$Res> {
  _$ConnectorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? provider = null,
    Object? description = null,
    Object? connected = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectorImplCopyWith<$Res>
    implements $ConnectorCopyWith<$Res> {
  factory _$$ConnectorImplCopyWith(
          _$ConnectorImpl value, $Res Function(_$ConnectorImpl) then) =
      __$$ConnectorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String provider, String description, bool connected});
}

/// @nodoc
class __$$ConnectorImplCopyWithImpl<$Res>
    extends _$ConnectorCopyWithImpl<$Res, _$ConnectorImpl>
    implements _$$ConnectorImplCopyWith<$Res> {
  __$$ConnectorImplCopyWithImpl(
      _$ConnectorImpl _value, $Res Function(_$ConnectorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? provider = null,
    Object? description = null,
    Object? connected = null,
  }) {
    return _then(_$ConnectorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      connected: null == connected
          ? _value.connected
          : connected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectorImpl implements _Connector {
  const _$ConnectorImpl(
      {required this.id,
      required this.provider,
      required this.description,
      required this.connected});

  factory _$ConnectorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectorImplFromJson(json);

  @override
  final String id;
  @override
  final String provider;
  @override
  final String description;
  @override
  final bool connected;

  @override
  String toString() {
    return 'Connector(id: $id, provider: $provider, description: $description, connected: $connected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.connected, connected) ||
                other.connected == connected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, provider, description, connected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectorImplCopyWith<_$ConnectorImpl> get copyWith =>
      __$$ConnectorImplCopyWithImpl<_$ConnectorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectorImplToJson(
      this,
    );
  }
}

abstract class _Connector implements Connector {
  const factory _Connector(
      {required final String id,
      required final String provider,
      required final String description,
      required final bool connected}) = _$ConnectorImpl;

  factory _Connector.fromJson(Map<String, dynamic> json) =
      _$ConnectorImpl.fromJson;

  @override
  String get id;
  @override
  String get provider;
  @override
  String get description;
  @override
  bool get connected;
  @override
  @JsonKey(ignore: true)
  _$$ConnectorImplCopyWith<_$ConnectorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardSnapshot _$DashboardSnapshotFromJson(Map<String, dynamic> json) {
  return _DashboardSnapshot.fromJson(json);
}

/// @nodoc
mixin _$DashboardSnapshot {
  List<HealthMetric> get metrics => throw _privateConstructorUsedError;
  List<TrendPoint> get trend => throw _privateConstructorUsedError;
  List<TrendPoint> get forecast => throw _privateConstructorUsedError;
  List<TimelineEvent> get timeline => throw _privateConstructorUsedError;
  String get insight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardSnapshotCopyWith<DashboardSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSnapshotCopyWith<$Res> {
  factory $DashboardSnapshotCopyWith(
          DashboardSnapshot value, $Res Function(DashboardSnapshot) then) =
      _$DashboardSnapshotCopyWithImpl<$Res, DashboardSnapshot>;
  @useResult
  $Res call(
      {List<HealthMetric> metrics,
      List<TrendPoint> trend,
      List<TrendPoint> forecast,
      List<TimelineEvent> timeline,
      String insight});
}

/// @nodoc
class _$DashboardSnapshotCopyWithImpl<$Res, $Val extends DashboardSnapshot>
    implements $DashboardSnapshotCopyWith<$Res> {
  _$DashboardSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metrics = null,
    Object? trend = null,
    Object? forecast = null,
    Object? timeline = null,
    Object? insight = null,
  }) {
    return _then(_value.copyWith(
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<HealthMetric>,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<TrendPoint>,
      forecast: null == forecast
          ? _value.forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as List<TrendPoint>,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<TimelineEvent>,
      insight: null == insight
          ? _value.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSnapshotImplCopyWith<$Res>
    implements $DashboardSnapshotCopyWith<$Res> {
  factory _$$DashboardSnapshotImplCopyWith(_$DashboardSnapshotImpl value,
          $Res Function(_$DashboardSnapshotImpl) then) =
      __$$DashboardSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<HealthMetric> metrics,
      List<TrendPoint> trend,
      List<TrendPoint> forecast,
      List<TimelineEvent> timeline,
      String insight});
}

/// @nodoc
class __$$DashboardSnapshotImplCopyWithImpl<$Res>
    extends _$DashboardSnapshotCopyWithImpl<$Res, _$DashboardSnapshotImpl>
    implements _$$DashboardSnapshotImplCopyWith<$Res> {
  __$$DashboardSnapshotImplCopyWithImpl(_$DashboardSnapshotImpl _value,
      $Res Function(_$DashboardSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metrics = null,
    Object? trend = null,
    Object? forecast = null,
    Object? timeline = null,
    Object? insight = null,
  }) {
    return _then(_$DashboardSnapshotImpl(
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as List<HealthMetric>,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<TrendPoint>,
      forecast: null == forecast
          ? _value._forecast
          : forecast // ignore: cast_nullable_to_non_nullable
              as List<TrendPoint>,
      timeline: null == timeline
          ? _value._timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<TimelineEvent>,
      insight: null == insight
          ? _value.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardSnapshotImpl implements _DashboardSnapshot {
  const _$DashboardSnapshotImpl(
      {required final List<HealthMetric> metrics,
      required final List<TrendPoint> trend,
      required final List<TrendPoint> forecast,
      required final List<TimelineEvent> timeline,
      required this.insight})
      : _metrics = metrics,
        _trend = trend,
        _forecast = forecast,
        _timeline = timeline;

  factory _$DashboardSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardSnapshotImplFromJson(json);

  final List<HealthMetric> _metrics;
  @override
  List<HealthMetric> get metrics {
    if (_metrics is EqualUnmodifiableListView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_metrics);
  }

  final List<TrendPoint> _trend;
  @override
  List<TrendPoint> get trend {
    if (_trend is EqualUnmodifiableListView) return _trend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trend);
  }

  final List<TrendPoint> _forecast;
  @override
  List<TrendPoint> get forecast {
    if (_forecast is EqualUnmodifiableListView) return _forecast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_forecast);
  }

  final List<TimelineEvent> _timeline;
  @override
  List<TimelineEvent> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  @override
  final String insight;

  @override
  String toString() {
    return 'DashboardSnapshot(metrics: $metrics, trend: $trend, forecast: $forecast, timeline: $timeline, insight: $insight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSnapshotImpl &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality().equals(other._forecast, _forecast) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline) &&
            (identical(other.insight, insight) || other.insight == insight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_metrics),
      const DeepCollectionEquality().hash(_trend),
      const DeepCollectionEquality().hash(_forecast),
      const DeepCollectionEquality().hash(_timeline),
      insight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSnapshotImplCopyWith<_$DashboardSnapshotImpl> get copyWith =>
      __$$DashboardSnapshotImplCopyWithImpl<_$DashboardSnapshotImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardSnapshotImplToJson(
      this,
    );
  }
}

abstract class _DashboardSnapshot implements DashboardSnapshot {
  const factory _DashboardSnapshot(
      {required final List<HealthMetric> metrics,
      required final List<TrendPoint> trend,
      required final List<TrendPoint> forecast,
      required final List<TimelineEvent> timeline,
      required final String insight}) = _$DashboardSnapshotImpl;

  factory _DashboardSnapshot.fromJson(Map<String, dynamic> json) =
      _$DashboardSnapshotImpl.fromJson;

  @override
  List<HealthMetric> get metrics;
  @override
  List<TrendPoint> get trend;
  @override
  List<TrendPoint> get forecast;
  @override
  List<TimelineEvent> get timeline;
  @override
  String get insight;
  @override
  @JsonKey(ignore: true)
  _$$DashboardSnapshotImplCopyWith<_$DashboardSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
