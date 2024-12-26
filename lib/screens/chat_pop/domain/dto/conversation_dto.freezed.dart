// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConversationDto _$ConversationDtoFromJson(Map<String, dynamic> json) {
  return _ConversationDto.fromJson(json);
}

/// @nodoc
mixin _$ConversationDto {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get lastMessage => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get lastMessageDateTime => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isMustBeOnTop => throw _privateConstructorUsedError;

  /// Serializes this ConversationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationDtoCopyWith<ConversationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationDtoCopyWith<$Res> {
  factory $ConversationDtoCopyWith(
          ConversationDto value, $Res Function(ConversationDto) then) =
      _$ConversationDtoCopyWithImpl<$Res, ConversationDto>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String lastMessage,
      @HiveField(3) DateTime lastMessageDateTime,
      @HiveField(4) bool isMustBeOnTop});
}

/// @nodoc
class _$ConversationDtoCopyWithImpl<$Res, $Val extends ConversationDto>
    implements $ConversationDtoCopyWith<$Res> {
  _$ConversationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lastMessage = null,
    Object? lastMessageDateTime = null,
    Object? isMustBeOnTop = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageDateTime: null == lastMessageDateTime
          ? _value.lastMessageDateTime
          : lastMessageDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMustBeOnTop: null == isMustBeOnTop
          ? _value.isMustBeOnTop
          : isMustBeOnTop // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationDtoImplCopyWith<$Res>
    implements $ConversationDtoCopyWith<$Res> {
  factory _$$ConversationDtoImplCopyWith(_$ConversationDtoImpl value,
          $Res Function(_$ConversationDtoImpl) then) =
      __$$ConversationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) String lastMessage,
      @HiveField(3) DateTime lastMessageDateTime,
      @HiveField(4) bool isMustBeOnTop});
}

/// @nodoc
class __$$ConversationDtoImplCopyWithImpl<$Res>
    extends _$ConversationDtoCopyWithImpl<$Res, _$ConversationDtoImpl>
    implements _$$ConversationDtoImplCopyWith<$Res> {
  __$$ConversationDtoImplCopyWithImpl(
      _$ConversationDtoImpl _value, $Res Function(_$ConversationDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lastMessage = null,
    Object? lastMessageDateTime = null,
    Object? isMustBeOnTop = null,
  }) {
    return _then(_$ConversationDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageDateTime: null == lastMessageDateTime
          ? _value.lastMessageDateTime
          : lastMessageDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMustBeOnTop: null == isMustBeOnTop
          ? _value.isMustBeOnTop
          : isMustBeOnTop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationDtoImpl implements _ConversationDto {
  _$ConversationDtoImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.lastMessage,
      @HiveField(3) required this.lastMessageDateTime,
      @HiveField(4) required this.isMustBeOnTop});

  factory _$ConversationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationDtoImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String lastMessage;
  @override
  @HiveField(3)
  final DateTime lastMessageDateTime;
  @override
  @HiveField(4)
  final bool isMustBeOnTop;

  @override
  String toString() {
    return 'ConversationDto(id: $id, name: $name, lastMessage: $lastMessage, lastMessageDateTime: $lastMessageDateTime, isMustBeOnTop: $isMustBeOnTop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageDateTime, lastMessageDateTime) ||
                other.lastMessageDateTime == lastMessageDateTime) &&
            (identical(other.isMustBeOnTop, isMustBeOnTop) ||
                other.isMustBeOnTop == isMustBeOnTop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, lastMessage, lastMessageDateTime, isMustBeOnTop);

  /// Create a copy of ConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationDtoImplCopyWith<_$ConversationDtoImpl> get copyWith =>
      __$$ConversationDtoImplCopyWithImpl<_$ConversationDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationDtoImplToJson(
      this,
    );
  }
}

abstract class _ConversationDto implements ConversationDto {
  factory _ConversationDto(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String lastMessage,
      @HiveField(3) required final DateTime lastMessageDateTime,
      @HiveField(4) required final bool isMustBeOnTop}) = _$ConversationDtoImpl;

  factory _ConversationDto.fromJson(Map<String, dynamic> json) =
      _$ConversationDtoImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get lastMessage;
  @override
  @HiveField(3)
  DateTime get lastMessageDateTime;
  @override
  @HiveField(4)
  bool get isMustBeOnTop;

  /// Create a copy of ConversationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationDtoImplCopyWith<_$ConversationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
