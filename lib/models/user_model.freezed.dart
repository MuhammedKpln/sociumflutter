// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String? get username => throw _privateConstructorUsedError;
  double? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  double? get gender => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  bool? get isEmailConfirmed => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  bool? get blockIncomingCalls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? username,
      double? id,
      String? email,
      double? gender,
      String? avatar,
      String? bio,
      bool? isEmailConfirmed,
      DateTime? birthday,
      bool? blockIncomingCalls});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? username = freezed,
    Object? id = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? avatar = freezed,
    Object? bio = freezed,
    Object? isEmailConfirmed = freezed,
    Object? birthday = freezed,
    Object? blockIncomingCalls = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as double?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as double?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmailConfirmed: isEmailConfirmed == freezed
          ? _value.isEmailConfirmed
          : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      blockIncomingCalls: blockIncomingCalls == freezed
          ? _value.blockIncomingCalls
          : blockIncomingCalls // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? username,
      double? id,
      String? email,
      double? gender,
      String? avatar,
      String? bio,
      bool? isEmailConfirmed,
      DateTime? birthday,
      bool? blockIncomingCalls});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, (v) => _then(v as _$_User));

  @override
  _$_User get _value => super._value as _$_User;

  @override
  $Res call({
    Object? username = freezed,
    Object? id = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? avatar = freezed,
    Object? bio = freezed,
    Object? isEmailConfirmed = freezed,
    Object? birthday = freezed,
    Object? blockIncomingCalls = freezed,
  }) {
    return _then(_$_User(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as double?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as double?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmailConfirmed: isEmailConfirmed == freezed
          ? _value.isEmailConfirmed
          : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
              as bool?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      blockIncomingCalls: blockIncomingCalls == freezed
          ? _value.blockIncomingCalls
          : blockIncomingCalls // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(
      {this.username,
      this.id,
      this.email,
      this.gender,
      this.avatar,
      this.bio,
      this.isEmailConfirmed,
      this.birthday,
      this.blockIncomingCalls});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String? username;
  @override
  final double? id;
  @override
  final String? email;
  @override
  final double? gender;
  @override
  final String? avatar;
  @override
  final String? bio;
  @override
  final bool? isEmailConfirmed;
  @override
  final DateTime? birthday;
  @override
  final bool? blockIncomingCalls;

  @override
  String toString() {
    return 'User(username: $username, id: $id, email: $email, gender: $gender, avatar: $avatar, bio: $bio, isEmailConfirmed: $isEmailConfirmed, birthday: $birthday, blockIncomingCalls: $blockIncomingCalls)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality().equals(other.bio, bio) &&
            const DeepCollectionEquality()
                .equals(other.isEmailConfirmed, isEmailConfirmed) &&
            const DeepCollectionEquality().equals(other.birthday, birthday) &&
            const DeepCollectionEquality()
                .equals(other.blockIncomingCalls, blockIncomingCalls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(bio),
      const DeepCollectionEquality().hash(isEmailConfirmed),
      const DeepCollectionEquality().hash(birthday),
      const DeepCollectionEquality().hash(blockIncomingCalls));

  @JsonKey(ignore: true)
  @override
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {final String? username,
      final double? id,
      final String? email,
      final double? gender,
      final String? avatar,
      final String? bio,
      final bool? isEmailConfirmed,
      final DateTime? birthday,
      final bool? blockIncomingCalls}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String? get username => throw _privateConstructorUsedError;
  @override
  double? get id => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  double? get gender => throw _privateConstructorUsedError;
  @override
  String? get avatar => throw _privateConstructorUsedError;
  @override
  String? get bio => throw _privateConstructorUsedError;
  @override
  bool? get isEmailConfirmed => throw _privateConstructorUsedError;
  @override
  DateTime? get birthday => throw _privateConstructorUsedError;
  @override
  bool? get blockIncomingCalls => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
