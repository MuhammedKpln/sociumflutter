import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/category.dart';
import 'package:scflutter/models/user.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room(
      {required int id,
      required String uuid,
      required DateTime expireDate,
      required DateTime created_at,
      required bool published,
      String? description,
      String? name,
      int? category,
      Category? category_data,
      List<RoomPartipication>? room_partipications_data}) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
class RoomPartipication with _$RoomPartipication {
  factory RoomPartipication(
      {required int id,
      required int room,
      required String user,
      required DateTime created_at,
      UserModel? user_data,
      Room? room_data}) = _RoomPartipication;

  factory RoomPartipication.fromJson(Map<String, dynamic> json) =>
      _$RoomPartipicationFromJson(json);
}
