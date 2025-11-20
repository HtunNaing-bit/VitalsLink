// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIInsight _$AIInsightFromJson(Map<String, dynamic> json) {
  return _AIInsight.fromJson(json);
}

/// @nodoc
mixin _$AIInsight {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get recommendation => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError; // 0.0 to 1.0
  List<String>? get dataPoints => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AIInsightCopyWith<AIInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIInsightCopyWith<$Res> {
  factory $AIInsightCopyWith(AIInsight value, $Res Function(AIInsight) then) =
      _$AIInsightCopyWithImpl<$Res, AIInsight>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String? recommendation,
      double confidence,
      List<String>? dataPoints,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$AIInsightCopyWithImpl<$Res, $Val extends AIInsight>
    implements $AIInsightCopyWith<$Res> {
  _$AIInsightCopyWithImpl(this._value, this._then);

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
    Object? recommendation = freezed,
    Object? confidence = null,
    Object? dataPoints = freezed,
    Object? timestamp = null,
    Object? metadata = freezed,
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
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      dataPoints: freezed == dataPoints
          ? _value.dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIInsightImplCopyWith<$Res>
    implements $AIInsightCopyWith<$Res> {
  factory _$$AIInsightImplCopyWith(
          _$AIInsightImpl value, $Res Function(_$AIInsightImpl) then) =
      __$$AIInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String? recommendation,
      double confidence,
      List<String>? dataPoints,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$AIInsightImplCopyWithImpl<$Res>
    extends _$AIInsightCopyWithImpl<$Res, _$AIInsightImpl>
    implements _$$AIInsightImplCopyWith<$Res> {
  __$$AIInsightImplCopyWithImpl(
      _$AIInsightImpl _value, $Res Function(_$AIInsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? recommendation = freezed,
    Object? confidence = null,
    Object? dataPoints = freezed,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(_$AIInsightImpl(
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
      recommendation: freezed == recommendation
          ? _value.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as String?,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      dataPoints: freezed == dataPoints
          ? _value._dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIInsightImpl implements _AIInsight {
  const _$AIInsightImpl(
      {required this.id,
      required this.title,
      required this.description,
      this.recommendation,
      this.confidence = 1.0,
      final List<String>? dataPoints,
      required this.timestamp,
      final Map<String, dynamic>? metadata})
      : _dataPoints = dataPoints,
        _metadata = metadata;

  factory _$AIInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIInsightImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String? recommendation;
  @override
  @JsonKey()
  final double confidence;
// 0.0 to 1.0
  final List<String>? _dataPoints;
// 0.0 to 1.0
  @override
  List<String>? get dataPoints {
    final value = _dataPoints;
    if (value == null) return null;
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime timestamp;
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
    return 'AIInsight(id: $id, title: $title, description: $description, recommendation: $recommendation, confidence: $confidence, dataPoints: $dataPoints, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality()
                .equals(other._dataPoints, _dataPoints) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      recommendation,
      confidence,
      const DeepCollectionEquality().hash(_dataPoints),
      timestamp,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      __$$AIInsightImplCopyWithImpl<_$AIInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIInsightImplToJson(
      this,
    );
  }
}

abstract class _AIInsight implements AIInsight {
  const factory _AIInsight(
      {required final String id,
      required final String title,
      required final String description,
      final String? recommendation,
      final double confidence,
      final List<String>? dataPoints,
      required final DateTime timestamp,
      final Map<String, dynamic>? metadata}) = _$AIInsightImpl;

  factory _AIInsight.fromJson(Map<String, dynamic> json) =
      _$AIInsightImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get recommendation;
  @override
  double get confidence;
  @override // 0.0 to 1.0
  List<String>? get dataPoints;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$AIInsightImplCopyWith<_$AIInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
