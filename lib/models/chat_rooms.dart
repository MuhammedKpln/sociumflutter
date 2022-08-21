import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:scflutter/models/user.dart';

part 'chat_rooms.freezed.dart';
part 'chat_rooms.g.dart';

@freezed
abstract class ChatRooms with _$ChatRooms {
  const factory ChatRooms({
    required int id,
    required DateTime created_at,
    required String text,
    required bool seen,
    required String user,
    required String receiver,
    required int room,
    required User receiver_data,
    required User user_data,
  }) = _ChatRooms;

  factory ChatRooms.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomsFromJson(json);
}
