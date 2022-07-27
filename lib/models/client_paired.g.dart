// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_paired.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClientPaired _$$_ClientPairedFromJson(Map<String, dynamic> json) =>
    _$_ClientPaired(
      room: json['room'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$$_ClientPairedToJson(_$_ClientPaired instance) =>
    <String, dynamic>{
      'room': instance.room,
      'user': instance.user,
      'uuid': instance.uuid,
    };
