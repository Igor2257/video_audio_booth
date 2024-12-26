// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatMessageDto _$ChatMessageDtoFromJson(Map<String, dynamic> json) {
  return _ChatMessageDto.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageDto {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get text => throw _privateConstructorUsedError;
  @HiveField(2)
  bool get isTail => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isSender => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isSent => throw _privateConstructorUsedError;
  @HiveField(5)
  String get conversationId => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get messageSentDateTime => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageDtoCopyWith<ChatMessageDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDtoCopyWith<$Res> {
  factory $ChatMessageDtoCopyWith(
          ChatMessageDto value, $Res Function(ChatMessageDto) then) =
      _$ChatMessageDtoCopyWithImpl<$Res, ChatMessageDto>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String text,
      @HiveField(2) bool isTail,
      @HiveField(3) bool isSender,
      @HiveField(4) bool isSent,
      @HiveField(5) String conversationId,
      @HiveField(6) DateTime messageSentDateTime});
}

/// @nodoc
class _$ChatMessageDtoCopyWithImpl<$Res, $Val extends ChatMessageDto>
    implements $ChatMessageDtoCopyWith<$Res> {
  _$ChatMessageDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isTail = null,
    Object? isSender = null,
    Object? isSent = null,
    Object? conversationId = null,
    Object? messageSentDateTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isTail: null == isTail
          ? _value.isTail
          : isTail // ignore: cast_nullable_to_non_nullable
              as bool,
      isSender: null == isSender
          ? _value.isSender
          : isSender // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      messageSentDateTime: null == messageSentDateTime
          ? _value.messageSentDateTime
          : messageSentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatMessageDtoImplCopyWith<$Res>
    implements $ChatMessageDtoCopyWith<$Res> {
  factory _$$ChatMessageDtoImplCopyWith(_$ChatMessageDtoImpl value,
          $Res Function(_$ChatMessageDtoImpl) then) =
      __$$ChatMessageDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String text,
      @HiveField(2) bool isTail,
      @HiveField(3) bool isSender,
      @HiveField(4) bool isSent,
      @HiveField(5) String conversationId,
      @HiveField(6) DateTime messageSentDateTime});
}

/// @nodoc
class __$$ChatMessageDtoImplCopyWithImpl<$Res>
    extends _$ChatMessageDtoCopyWithImpl<$Res, _$ChatMessageDtoImpl>
    implements _$$ChatMessageDtoImplCopyWith<$Res> {
  __$$ChatMessageDtoImplCopyWithImpl(
      _$ChatMessageDtoImpl _value, $Res Function(_$ChatMessageDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isTail = null,
    Object? isSender = null,
    Object? isSent = null,
    Object? conversationId = null,
    Object? messageSentDateTime = null,
  }) {
    return _then(_$ChatMessageDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isTail: null == isTail
          ? _value.isTail
          : isTail // ignore: cast_nullable_to_non_nullable
              as bool,
      isSender: null == isSender
          ? _value.isSender
          : isSender // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      messageSentDateTime: null == messageSentDateTime
          ? _value.messageSentDateTime
          : messageSentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageDtoImpl implements _ChatMessageDto {
  _$ChatMessageDtoImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.text,
      @HiveField(2) this.isTail = false,
      @HiveField(3) this.isSender = false,
      @HiveField(4) this.isSent = false,
      @HiveField(5) required this.conversationId,
      @HiveField(6) required this.messageSentDateTime});

  factory _$ChatMessageDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDtoImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String text;
  @override
  @JsonKey()
  @HiveField(2)
  final bool isTail;
  @override
  @JsonKey()
  @HiveField(3)
  final bool isSender;
  @override
  @JsonKey()
  @HiveField(4)
  final bool isSent;
  @override
  @HiveField(5)
  final String conversationId;
  @override
  @HiveField(6)
  final DateTime messageSentDateTime;

  @override
  String toString() {
    return 'ChatMessageDto(id: $id, text: $text, isTail: $isTail, isSender: $isSender, isSent: $isSent, conversationId: $conversationId, messageSentDateTime: $messageSentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isTail, isTail) || other.isTail == isTail) &&
            (identical(other.isSender, isSender) ||
                other.isSender == isSender) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.messageSentDateTime, messageSentDateTime) ||
                other.messageSentDateTime == messageSentDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, isTail, isSender,
      isSent, conversationId, messageSentDateTime);

  /// Create a copy of ChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDtoImplCopyWith<_$ChatMessageDtoImpl> get copyWith =>
      __$$ChatMessageDtoImplCopyWithImpl<_$ChatMessageDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDtoImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageDto implements ChatMessageDto {
  factory _ChatMessageDto(
          {@HiveField(0) required final String id,
          @HiveField(1) required final String text,
          @HiveField(2) final bool isTail,
          @HiveField(3) final bool isSender,
          @HiveField(4) final bool isSent,
          @HiveField(5) required final String conversationId,
          @HiveField(6) required final DateTime messageSentDateTime}) =
      _$ChatMessageDtoImpl;

  factory _ChatMessageDto.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDtoImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get text;
  @override
  @HiveField(2)
  bool get isTail;
  @override
  @HiveField(3)
  bool get isSender;
  @override
  @HiveField(4)
  bool get isSent;
  @override
  @HiveField(5)
  String get conversationId;
  @override
  @HiveField(6)
  DateTime get messageSentDateTime;

  /// Create a copy of ChatMessageDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageDtoImplCopyWith<_$ChatMessageDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
