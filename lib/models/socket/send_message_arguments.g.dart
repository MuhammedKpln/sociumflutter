// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SendMessageArguments _$$_SendMessageArgumentsFromJson(
        Map<String, dynamic> json) =>
    _$_SendMessageArguments(
      room: json['room'] as String,
      message: json['message'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      receiver: User.fromJson(json['receiver'] as Map<String, dynamic>),
      repliedToId: json['repliedToId'] as int?,
    );

Map<String, dynamic> _$$_SendMessageArgumentsToJson(
        _$_SendMessageArguments instance) =>
    <String, dynamic>{
      'room': instance.room,
      'message': instance.message,
      'user': instance.user,
      'receiver': instance.receiver,
      'repliedToId': instance.repliedToId,
    };
