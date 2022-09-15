import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository with LoggerMixin {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final RoomRepository _roomRepository = RoomRepository();
  final String _table = "messages";

  SupabaseQueryBuilder get _query => _supabaseClient.from(_table);

  Future<List<Message>> fetchAllChatRooms({required String id}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    var data = await _supabaseClient
        .from('get_messages_room')
        .select(query)
        .or("user.eq.$id,receiver.eq.$id")
        .eq("group_message", false)
        .execute();

    if (data.hasError) {
      logError(data.error);
    }

    return List<Message>.from(data.data.map((x) => Message.fromJson(x)));
  }

  Future<List<Message>> fetchChatMessages({required int roomId}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    final request = await _query
        .select(query)
        .eq("room", roomId)
        .order("created_at", ascending: false)
        .execute();

    if (request.hasError) {
      logError(request.error);
    }

    print(request.data);

    return List<Message>.from(request.data.map((x) => Message.fromJson(x)));
  }

  Future<void> sendMessage(SendMessage message) async {
    final request = await _query.insert(message.toJson()).execute();

    if (request.hasError) {
      logError(request.error);
    }
  }

  RealtimeSubscription listenMessages(
      int roomId, Function(SupabaseRealtimePayload payload) callback) {
    return Supabase.instance.client
        .from("messages:room=eq.$roomId")
        .on(SupabaseEventTypes.all, callback)
        .subscription;
  }

  Future<bool> Function({required int roomId}) get deleteRoom =>
      _roomRepository.deleteRoom;
}
