import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/message.dart';

part 'message_received_response.freezed.dart';
part 'message_received_response.g.dart';

@freezed
abstract class MessageReceivedResponse with _$MessageReceivedResponse {
  const factory MessageReceivedResponse({required Message message}) =
      _MessageReceivedResponse;

  factory MessageReceivedResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageReceivedResponseFromJson(json);
}
