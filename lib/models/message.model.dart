import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';

part 'message.model.freezed.dart';
part 'message.model.g.dart';

@freezed
class Message with _$Message {
  factory Message({
    required String id,
    required String text,
    required bool seen,
    required String user,
    required String receiver,
    required String room,
    required UserModel user_data,
    required UserModel receiver_data,
    required Room room_data,
    required String created_at,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
