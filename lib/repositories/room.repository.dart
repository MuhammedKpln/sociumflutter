import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomRepository extends BaseRepositoryClass {
  final SupabaseQueryBuilder _builder = Supabase.instance.client.from('rooms');

  RoomRepository();

  Future<List<Room>> fetchPublishedRooms() async {
    String select = """*,
      room_partipications_data:room_partipications(*,user_data:users(*))
""";

    try {
      final request =
          await supabase.from("rooms").select(select).eq("published", true);

      return List.from(request.data.map((data) => Room.fromJson(data)));
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<List<RoomPartipication>> fetchJoinedRooms(
      {required String userId}) async {
    String select = """*,
      room_data:room(*)
""";

    try {
      final request = await supabase
          .from("room_partipications")
          .select(select)
          .eq("user", userId);

      return List.from(
          request.data.map((data) => RoomPartipication.fromJson(data)));
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<Room> fetchRoomDetails({required int roomId}) async {
    String select = """*,
      room_partipications_data:room_partipications(*,user_data:users(*)),
      category_data:categories(*)
""";

    try {
      final request = await supabase
          .from("rooms")
          .select(select)
          .eq("id", roomId)
          .limit(1)
          .single();

      return Room.fromJson(request.data);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<bool> leaveCommunity(
      {required int roomId, required String userId}) async {
    try {
      await supabase
          .from("room_partipications")
          .delete()
          .eq("user", userId)
          .eq("room", roomId);

      return true;
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<RoomPartipication> joinCommunity(
      {required int roomId, required String userId}) async {
    try {
      final request = await supabase
          .from("room_partipications")
          .upsert({"room": roomId, "user": userId});

      return RoomPartipication.fromJson(request.data.first);
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }

  Future<bool> deleteRoom({required int roomId}) async {
    try {
      await _builder.delete().eq("id", roomId);
      return true;
    } catch (error) {
      logError(error);
      throw Exception(error);
    }
  }
}
