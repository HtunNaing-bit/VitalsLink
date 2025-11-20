// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AIMessage _$AIMessageFromJson(Map<String, dynamic> json) {
  return _AIMessage.fromJson(json);
}

/// @nodoc
mixin _$AIMessage {
  String get id => throw _privateConstructorUsedError;
  ChatRole get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<String> get dataPoints =>
      throw _privateConstructorUsedError; // Data points used in response
  double? get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AIMessageCopyWith<AIMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIMessageCopyWith<$Res> {
  factory $AIMessageCopyWith(AIMessage value, $Res Function(AIMessage) then) =
      _$AIMessageCopyWithImpl<$Res, AIMessage>;
  @useResult
  $Res call(
      {String id,
      ChatRole role,
      String content,
      DateTime timestamp,
      List<String> dataPoints,
      double? confidence});
}

/// @nodoc
class _$AIMessageCopyWithImpl<$Res, $Val extends AIMessage>
    implements $AIMessageCopyWith<$Res> {
  _$AIMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? content = null,
    Object? timestamp = null,
    Object? dataPoints = null,
    Object? confidence = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as ChatRole,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dataPoints: null == dataPoints
          ? _value.dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIMessageImplCopyWith<$Res>
    implements $AIMessageCopyWith<$Res> {
  factory _$$AIMessageImplCopyWith(
          _$AIMessageImpl value, $Res Function(_$AIMessageImpl) then) =
      __$$AIMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      ChatRole role,
      String content,
      DateTime timestamp,
      List<String> dataPoints,
      double? confidence});
}

/// @nodoc
class __$$AIMessageImplCopyWithImpl<$Res>
    extends _$AIMessageCopyWithImpl<$Res, _$AIMessageImpl>
    implements _$$AIMessageImplCopyWith<$Res> {
  __$$AIMessageImplCopyWithImpl(
      _$AIMessageImpl _value, $Res Function(_$AIMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? content = null,
    Object? timestamp = null,
    Object? dataPoints = null,
    Object? confidence = freezed,
  }) {
    return _then(_$AIMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as ChatRole,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dataPoints: null == dataPoints
          ? _value._dataPoints
          : dataPoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIMessageImpl implements _AIMessage {
  const _$AIMessageImpl(
      {required this.id,
      required this.role,
      required this.content,
      required this.timestamp,
      final List<String> dataPoints = const [],
      this.confidence})
      : _dataPoints = dataPoints;

  factory _$AIMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIMessageImplFromJson(json);

  @override
  final String id;
  @override
  final ChatRole role;
  @override
  final String content;
  @override
  final DateTime timestamp;
  final List<String> _dataPoints;
  @override
  @JsonKey()
  List<String> get dataPoints {
    if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataPoints);
  }

// Data points used in response
  @override
  final double? confidence;

  @override
  String toString() {
    return 'AIMessage(id: $id, role: $role, content: $content, timestamp: $timestamp, dataPoints: $dataPoints, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._dataPoints, _dataPoints) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, content, timestamp,
      const DeepCollectionEquality().hash(_dataPoints), confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AIMessageImplCopyWith<_$AIMessageImpl> get copyWith =>
      __$$AIMessageImplCopyWithImpl<_$AIMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIMessageImplToJson(
      this,
    );
  }
}

abstract class _AIMessage implements AIMessage {
  const factory _AIMessage(
      {required final String id,
      required final ChatRole role,
      required final String content,
      required final DateTime timestamp,
      final List<String> dataPoints,
      final double? confidence}) = _$AIMessageImpl;

  factory _AIMessage.fromJson(Map<String, dynamic> json) =
      _$AIMessageImpl.fromJson;

  @override
  String get id;
  @override
  ChatRole get role;
  @override
  String get content;
  @override
  DateTime get timestamp;
  @override
  List<String> get dataPoints;
  @override // Data points used in response
  double? get confidence;
  @override
  @JsonKey(ignore: true)
  _$$AIMessageImplCopyWith<_$AIMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AIAction _$AIActionFromJson(Map<String, dynamic> json) {
  return _AIAction.fromJson(json);
}

/// @nodoc
mixin _$AIAction {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get command => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AIActionCopyWith<AIAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AIActionCopyWith<$Res> {
  factory $AIActionCopyWith(AIAction value, $Res Function(AIAction) then) =
      _$AIActionCopyWithImpl<$Res, AIAction>;
  @useResult
  $Res call({String id, String title, String description, String command});
}

/// @nodoc
class _$AIActionCopyWithImpl<$Res, $Val extends AIAction>
    implements $AIActionCopyWith<$Res> {
  _$AIActionCopyWithImpl(this._value, this._then);

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
    Object? command = null,
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
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AIActionImplCopyWith<$Res>
    implements $AIActionCopyWith<$Res> {
  factory _$$AIActionImplCopyWith(
          _$AIActionImpl value, $Res Function(_$AIActionImpl) then) =
      __$$AIActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String description, String command});
}

/// @nodoc
class __$$AIActionImplCopyWithImpl<$Res>
    extends _$AIActionCopyWithImpl<$Res, _$AIActionImpl>
    implements _$$AIActionImplCopyWith<$Res> {
  __$$AIActionImplCopyWithImpl(
      _$AIActionImpl _value, $Res Function(_$AIActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? command = null,
  }) {
    return _then(_$AIActionImpl(
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
      command: null == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AIActionImpl implements _AIAction {
  const _$AIActionImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.command});

  factory _$AIActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AIActionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String command;

  @override
  String toString() {
    return 'AIAction(id: $id, title: $title, description: $description, command: $command)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AIActionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.command, command) || other.command == command));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, command);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AIActionImplCopyWith<_$AIActionImpl> get copyWith =>
      __$$AIActionImplCopyWithImpl<_$AIActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AIActionImplToJson(
      this,
    );
  }
}

abstract class _AIAction implements AIAction {
  const factory _AIAction(
      {required final String id,
      required final String title,
      required final String description,
      required final String command}) = _$AIActionImpl;

  factory _AIAction.fromJson(Map<String, dynamic> json) =
      _$AIActionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get command;
  @override
  @JsonKey(ignore: true)
  _$$AIActionImplCopyWith<_$AIActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
