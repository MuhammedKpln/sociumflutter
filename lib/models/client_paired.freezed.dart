// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'client_paired.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClientPaired _$ClientPairedFromJson(Map<String, dynamic> json) {
  return _ClientPaired.fromJson(json);
}

/// @nodoc
mixin _$ClientPaired {
  String get room => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientPairedCopyWith<ClientPaired> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPairedCopyWith<$Res> {
  factory $ClientPairedCopyWith(
          ClientPaired value, $Res Function(ClientPaired) then) =
      _$ClientPairedCopyWithImpl<$Res>;
  $Res call({String room, User user, String uuid});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$ClientPairedCopyWithImpl<$Res> implements $ClientPairedCopyWith<$Res> {
  _$ClientPairedCopyWithImpl(this._value, this._then);

  final ClientPaired _value;
  // ignore: unused_field
  final $Res Function(ClientPaired) _then;

  @override
  $Res call({
    Object? room = freezed,
    Object? user = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_value.copyWith(
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_ClientPairedCopyWith<$Res>
    implements $ClientPairedCopyWith<$Res> {
  factory _$$_ClientPairedCopyWith(
          _$_ClientPaired value, $Res Function(_$_ClientPaired) then) =
      __$$_ClientPairedCopyWithImpl<$Res>;
  @override
  $Res call({String room, User user, String uuid});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_ClientPairedCopyWithImpl<$Res>
    extends _$ClientPairedCopyWithImpl<$Res>
    implements _$$_ClientPairedCopyWith<$Res> {
  __$$_ClientPairedCopyWithImpl(
      _$_ClientPaired _value, $Res Function(_$_ClientPaired) _then)
      : super(_value, (v) => _then(v as _$_ClientPaired));

  @override
  _$_ClientPaired get _value => super._value as _$_ClientPaired;

  @override
  $Res call({
    Object? room = freezed,
    Object? user = freezed,
    Object? uuid = freezed,
  }) {
    return _then(_$_ClientPaired(
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      uuid: uuid == freezed
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClientPaired implements _ClientPaired {
  const _$_ClientPaired(
      {required this.room, required this.user, required this.uuid});

  factory _$_ClientPaired.fromJson(Map<String, dynamic> json) =>
      _$$_ClientPairedFromJson(json);

  @override
  final String room;
  @override
  final User user;
  @override
  final String uuid;

  @override
  String toString() {
    return 'ClientPaired(room: $room, user: $user, uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientPaired &&
            const DeepCollectionEquality().equals(other.room, room) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(room),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(uuid));

  @JsonKey(ignore: true)
  @override
  _$$_ClientPairedCopyWith<_$_ClientPaired> get copyWith =>
      __$$_ClientPairedCopyWithImpl<_$_ClientPaired>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientPairedToJson(this);
  }
}

abstract class _ClientPaired implements ClientPaired {
  const factory _ClientPaired(
      {required final String room,
      required final User user,
      required final String uuid}) = _$_ClientPaired;

  factory _ClientPaired.fromJson(Map<String, dynamic> json) =
      _$_ClientPaired.fromJson;

  @override
  String get room => throw _privateConstructorUsedError;
  @override
  User get user => throw _privateConstructorUsedError;
  @override
  String get uuid => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ClientPairedCopyWith<_$_ClientPaired> get copyWith =>
      throw _privateConstructorUsedError;
}
