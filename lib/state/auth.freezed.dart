// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthStateModel _$AuthStateModelFromJson(Map<String, dynamic> json) {
  return _AuthStateModel.fromJson(json);
}

/// @nodoc
mixin _$AuthStateModel {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthStateModelCopyWith<AuthStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateModelCopyWith<$Res> {
  factory $AuthStateModelCopyWith(
          AuthStateModel value, $Res Function(AuthStateModel) then) =
      _$AuthStateModelCopyWithImpl<$Res>;
  $Res call({String? accessToken, String? refreshToken, User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuthStateModelCopyWithImpl<$Res>
    implements $AuthStateModelCopyWith<$Res> {
  _$AuthStateModelCopyWithImpl(this._value, this._then);

  final AuthStateModel _value;
  // ignore: unused_field
  final $Res Function(AuthStateModel) _then;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_AuthStateModelCopyWith<$Res>
    implements $AuthStateModelCopyWith<$Res> {
  factory _$$_AuthStateModelCopyWith(
          _$_AuthStateModel value, $Res Function(_$_AuthStateModel) then) =
      __$$_AuthStateModelCopyWithImpl<$Res>;
  @override
  $Res call({String? accessToken, String? refreshToken, User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_AuthStateModelCopyWithImpl<$Res>
    extends _$AuthStateModelCopyWithImpl<$Res>
    implements _$$_AuthStateModelCopyWith<$Res> {
  __$$_AuthStateModelCopyWithImpl(
      _$_AuthStateModel _value, $Res Function(_$_AuthStateModel) _then)
      : super(_value, (v) => _then(v as _$_AuthStateModel));

  @override
  _$_AuthStateModel get _value => super._value as _$_AuthStateModel;

  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_AuthStateModel(
      accessToken: accessToken == freezed
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthStateModel implements _AuthStateModel {
  const _$_AuthStateModel({this.accessToken, this.refreshToken, this.user});

  factory _$_AuthStateModel.fromJson(Map<String, dynamic> json) =>
      _$$_AuthStateModelFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final User? user;

  @override
  String toString() {
    return 'AuthStateModel(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStateModel &&
            const DeepCollectionEquality()
                .equals(other.accessToken, accessToken) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accessToken),
      const DeepCollectionEquality().hash(refreshToken),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStateModelCopyWith<_$_AuthStateModel> get copyWith =>
      __$$_AuthStateModelCopyWithImpl<_$_AuthStateModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthStateModelToJson(this);
  }
}

abstract class _AuthStateModel implements AuthStateModel {
  const factory _AuthStateModel(
      {final String? accessToken,
      final String? refreshToken,
      final User? user}) = _$_AuthStateModel;

  factory _AuthStateModel.fromJson(Map<String, dynamic> json) =
      _$_AuthStateModel.fromJson;

  @override
  String? get accessToken => throw _privateConstructorUsedError;
  @override
  String? get refreshToken => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateModelCopyWith<_$_AuthStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
