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
class RoomWithPartipicationsData with _$RoomWithPartipicationsData {
  factory RoomWithPartipicationsData({
    required int id,
    required String uuid,
    required DateTime expireDate,
    required DateTime created_at,
    required bool published,
    required List<RoomPartipicationWithUserData?> room_partipications_data,
    String? name,
  }) = _RoomWithPartipicationsData;

  factory RoomWithPartipicationsData.fromJson(Map<String, dynamic> json) =>
      _$RoomWithPartipicationsDataFromJson(json);
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

@freezed
class RoomPartipicationWithUserData with _$RoomPartipicationWithUserData {
  factory RoomPartipicationWithUserData(
      {required int id,
      required int room,
      required String user,
      required UserModel user_data,
      required DateTime created_at}) = _RoomPartipicationWithUserData;

  factory RoomPartipicationWithUserData.fromJson(Map<String, dynamic> json) =>
      _$RoomPartipicationWithUserDataFromJson(json);
}

@freezed
class RoomPartipicationWithRoomData with _$RoomPartipicationWithRoomData {
  factory RoomPartipicationWithRoomData(
      {required int id,
      required int room,
      required String user,
      required Room room_data,
      required DateTime created_at}) = _RoomPartipicationWithRoomData;

  factory RoomPartipicationWithRoomData.fromJson(Map<String, dynamic> json) =>
      _$RoomPartipicationWithRoomDataFromJson(json);
}

@freezed
class RoomPartipicationWithAllRelations
    with _$RoomPartipicationWithAllRelations {
  factory RoomPartipicationWithAllRelations(
      {required int id,
      required int room,
      required String user,
      required Room room_data,
      required UserModel user_data,
      required DateTime created_at,
      int? category}) = _RoomPartipicationWithAllRelations;

  factory RoomPartipicationWithAllRelations.fromJson(
          Map<String, dynamic> json) =>
      _$RoomPartipicationWithAllRelationsFromJson(json);
}
