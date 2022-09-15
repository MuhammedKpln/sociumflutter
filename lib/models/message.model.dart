import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';

part 'message.model.freezed.dart';
part 'message.model.g.dart';

@freezed
class Message with _$Message {
  factory Message({
    required int id,
    required String text,
    required bool seen,
    required String user,
    required int room,
    required DateTime created_at,
    UserModel? user_data,
    Room? room_data,
    String? receiver,
    UserModel? receiver_data,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class SendMessage with _$SendMessage {
  factory SendMessage(
      {required String text,
      required bool seen,
      required String user,
      required int room,
      String? receiver,
      bool? group_message}) = _SendMessage;

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);
}
