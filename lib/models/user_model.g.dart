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

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'email': instance.email,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'isEmailConfirmed': instance.isEmailConfirmed,
      'birthday': instance.birthday?.toIso8601String(),
      'blockIncomingCalls': instance.blockIncomingCalls,
    };
