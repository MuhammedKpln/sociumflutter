// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_received_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageReceivedResponse _$MessageReceivedResponseFromJson(
    Map<String, dynamic> json) {
  return _MessageReceivedResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageReceivedResponse {
  Message get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageReceivedResponseCopyWith<MessageReceivedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageReceivedResponseCopyWith<$Res> {
  factory $MessageReceivedResponseCopyWith(MessageReceivedResponse value,
          $Res Function(MessageReceivedResponse) then) =
      _$MessageReceivedResponseCopyWithImpl<$Res>;
  $Res call({Message message});

  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class _$MessageReceivedResponseCopyWithImpl<$Res>
    implements $MessageReceivedResponseCopyWith<$Res> {
  _$MessageReceivedResponseCopyWithImpl(this._value, this._then);

  final MessageReceivedResponse _value;
  // ignore: unused_field
  final $Res Function(MessageReceivedResponse) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }

  @override
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageReceivedResponseCopyWith<$Res>
    implements $MessageReceivedResponseCopyWith<$Res> {
  factory _$$_MessageReceivedResponseCopyWith(_$_MessageReceivedResponse value,
          $Res Function(_$_MessageReceivedResponse) then) =
      __$$_MessageReceivedResponseCopyWithImpl<$Res>;
  @override
  $Res call({Message message});

  @override
  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_MessageReceivedResponseCopyWithImpl<$Res>
    extends _$MessageReceivedResponseCopyWithImpl<$Res>
    implements _$$_MessageReceivedResponseCopyWith<$Res> {
  __$$_MessageReceivedResponseCopyWithImpl(_$_MessageReceivedResponse _value,
      $Res Function(_$_MessageReceivedResponse) _then)
      : super(_value, (v) => _then(v as _$_MessageReceivedResponse));

  @override
  _$_MessageReceivedResponse get _value =>
      super._value as _$_MessageReceivedResponse;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$_MessageReceivedResponse(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageReceivedResponse implements _MessageReceivedResponse {
  const _$_MessageReceivedResponse({required this.message});

  factory _$_MessageReceivedResponse.fromJson(Map<String, dynamic> json) =>
      _$$_MessageReceivedResponseFromJson(json);

  @override
  final Message message;

  @override
  String toString() {
    return 'MessageReceivedResponse(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageReceivedResponse &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_MessageReceivedResponseCopyWith<_$_MessageReceivedResponse>
      get copyWith =>
          __$$_MessageReceivedResponseCopyWithImpl<_$_MessageReceivedResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageReceivedResponseToJson(this);
  }
}

abstract class _MessageReceivedResponse implements MessageReceivedResponse {
  const factory _MessageReceivedResponse({required final Message message}) =
      _$_MessageReceivedResponse;

  factory _MessageReceivedResponse.fromJson(Map<String, dynamic> json) =
      _$_MessageReceivedResponse.fromJson;

  @override
  Message get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageReceivedResponseCopyWith<_$_MessageReceivedResponse>
      get copyWith => throw _privateConstructorUsedError;
}
