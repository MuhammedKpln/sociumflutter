import 'package:scflutter/repositories/_base.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomRepository extends BaseRepositoryClass {
  final SupabaseQueryBuilder _builder = Supabase.instance.client.from('rooms');

  RoomRepository()
      : super(BaseRepositoryArguments(userData: true, roomData: true));

  Future<PostgrestResponse> fetchPublishedRooms() async {
    String select = """*,
      room_partipications_data:room_partipications(*,user_data:users(*))
""";

    final request = await supabase
        .from("rooms")
        .select(select)
        .eq("published", true)
        .execute(count: CountOption.estimated);

    if (request.hasError) {
      logError(request.error);
      throw Exception(request.error);
    }

    return request;
  }

  Future<PostgrestResponse> fetchJoinedRooms({required String userId}) async {
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

    return request;
  }
}
