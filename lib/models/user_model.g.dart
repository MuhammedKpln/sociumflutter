// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      username: json['username'] as String?,
      id: (json['id'] as num?)?.toDouble(),
      email: json['email'] as String?,
      gender: (json['gender'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      isEmailConfirmed: json['isEmailConfirmed'] as bool?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      blockIncomingCalls: json['blockIncomingCalls'] as bool?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  writeNotNull('isEmailConfirmed', instance.isEmailConfirmed);
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}
