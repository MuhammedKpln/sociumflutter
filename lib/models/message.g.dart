// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      id: (json['id'] as num).toDouble(),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
      message: json['message'] as String,
      seen: json['seen'] as bool,
      roomId: (json['roomId'] as num).toDouble(),
      senderId: (json['senderId'] as num).toDouble(),
      receiverId: (json['receiverId'] as num).toDouble(),
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
      receiver: User.fromJson(json['receiver'] as Map<String, dynamic>),
      sender: User.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
      'message': instance.message,
      'seen': instance.seen,
      'roomId': instance.roomId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'room': instance.room,
      'receiver': instance.receiver,
      'sender': instance.sender,
    };

_$_Room _$$_RoomFromJson(Map<String, dynamic> json) => _$_Room(
      id: (json['id'] as num).toDouble(),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
      roomAdress: json['roomAdress'] as String,
      expireDate: DateTime.parse(json['expireDate'] as String),
    );

Map<String, dynamic> _$$_RoomToJson(_$_Room instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
      'roomAdress': instance.roomAdress,
      'expireDate': instance.expireDate.toIso8601String(),
    };
