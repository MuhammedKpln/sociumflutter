import 'package:scflutter/models/chat_rooms.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository with LoggerMixin {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String _table = "messages";

  SupabaseQueryBuilder get _query => _supabaseClient.from(_table);

  Future<List<ChatRooms>> fetchAllChatRooms({required String id}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    var data = await _supabaseClient
        .from('get_messages_room')
        .select(query)
        .or("user.eq.$id,receiver.eq.$id")
        .execute();

    if (data.hasError) {
      logError(data.error);
    }

    return List<ChatRooms>.from(data.data.map((x) => ChatRooms.fromJson(x)));
  }

  Future<List<Message>> fetchChatMessages({required int roomId}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    final request = await _query.select(query).eq("room", roomId).execute();

    if (request.hasError) {
      logError(request.error);
    }

    print(request.data);

    return List<Message>.from(request.data.map((x) => Message.fromJson(x)));
  }

  listenMessages(Function(SupabaseRealtimePayload payload) callback) {
    return _supabaseClient.from("messages").stream(["id"]);
  }
}
