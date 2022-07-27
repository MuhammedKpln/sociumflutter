import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/user_model.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required double id,
    required DateTime created_at,
    required DateTime updated_at,
    required String message,
    required bool seen,
    required double roomId,
    required double senderId,
    required double receiverId,
    required Room room,
    required User receiver,
    required User sender,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
abstract class Room with _$Room {
  const factory Room({
    required double id,
    required DateTime created_at,
    required DateTime updated_at,
    required String roomAdress,
    required DateTime expireDate,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
