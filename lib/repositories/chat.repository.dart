import 'dart:async';

import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/repositories/room.repository.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepository with LoggerMixin {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final RoomRepository _roomRepository = RoomRepository();
  final String _table = "messages";

  SupabaseQueryBuilder get _query => _supabaseClient.from(_table);

  Future<List<Message>> fetchPrivateChats({required String id}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    try {
      final request = await _supabaseClient
          .from('get_messages_room')
          .select(query)
          .or("user.eq.$id,receiver.eq.$id")
          .eq("group_message", false);

      return List<Message>.from(request.map((x) => Message.fromJson(x)));
    } catch (err) {
      logError(err);
      throw Exception(err);
    }
  }

  Future<List<Message>> fetchCommunityChats({required String id}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*, room_partipications_data:room_partipications(*))

                   """;

    try {
      var data = await _supabaseClient
          .from('get_messages_room')
          .select(query)
          .or("user.eq.$id,receiver.eq.$id")
          .eq("group_message", true);

      return List<Message>.from(data.data.map((x) => Message.fromJson(x)));
    } catch (err) {
      logError(err);
      throw Exception(err);
    }
  }

  Future<List<Message>> fetchChatMessages({required int roomId}) async {
    const query = """*,
                    user_data:user(*),
                    receiver_data:receiver(*),
                    room_data:room(*)
                   """;

    try {
      final request = await _query
          .select(query)
          .eq("room", roomId)
          .order("created_at", ascending: false);

      return List<Message>.from(request.map((x) => Message.fromJson(x)));
    } catch (err) {
      logError(err);
      throw Exception(err);
    }
  }

  Future<void> sendMessage(SendMessage message) async {
    try {
      await _query.insert(message.toJson());
    } catch (err) {
      logError(err);
    }
  }

  StreamSubscription listenMessages(
      int roomId, Function(dynamic payload) callback) {
    return Supabase.instance.client
        .from("messages:room=eq.$roomId")
        .stream(["id"]).listen(callback);
  }

  Future<bool> Function({required int roomId}) get deleteRoom =>
      _roomRepository.deleteRoom;
}
