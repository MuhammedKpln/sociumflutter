import 'package:scflutter/models/room.dart';
import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomRepository extends BaseRepositoryClass {
  final SupabaseQueryBuilder _builder = Supabase.instance.client.from('rooms');

  RoomRepository()
      : super(BaseRepositoryArguments(userData: true, roomData: true));

  Future<List<Room>> fetchPublishedRooms() async {
    String select = """*,
      room_partipications_data:room_partipications(*,user_data:users(*))
""";

    final request = await supabase
        .from("rooms")
        .select(select)
        .eq("published", true)
        .execute();

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return List.from(request.data.map((data) => Room.fromJson(data)));
  }

  Future<List<RoomPartipication>> fetchJoinedRooms(
      {required String userId}) async {
    String select = """*,
      room_data:room(*)
""";

    final request = await supabase
        .from("room_partipications")
        .select(select)
        .eq("user", userId)
        .execute(count: CountOption.estimated);

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return List.from(
        request.data.map((data) => RoomPartipication.fromJson(data)));
  }

  Future<Room> fetchRoomDetails({required int roomId}) async {
    String select = """*,
      room_partipications_data:room_partipications(*,user_data:users(*)),
      category_data:categories(*)
""";

    final request = await supabase
        .from("rooms")
        .select(select)
        .eq("id", roomId)
        .limit(1)
        .single()
        .execute();

    print(request.data);

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return Room.fromJson(request.data);
  }

  Future<bool> leaveCommunity(
      {required int roomId, required String userId}) async {
    final request = await supabase
        .from("room_partipications")
        .delete()
        .eq("user", userId)
        .eq("room", roomId)
        .execute();

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return true;
  }

  Future<RoomPartipication> joinCommunity(
      {required int roomId, required String userId}) async {
    final request = await supabase
        .from("room_partipications")
        .upsert({"room": roomId, "user": userId}).execute();

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return RoomPartipication.fromJson(request.data.first);
  }
}
