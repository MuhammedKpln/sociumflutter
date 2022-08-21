import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/user.dart';

part 'send_message_arguments.freezed.dart';
part 'send_message_arguments.g.dart';

@freezed
abstract class SendMessageArguments with _$SendMessageArguments {
  const factory SendMessageArguments({
    required String room,
    required String text,
    required UserModel user,
    required UserModel receiver,
    int? repliedToId,
  }) = _SendMessageArguments;

  factory SendMessageArguments.fromJson(Map<String, dynamic> json) =>
      _$SendMessageArgumentsFromJson(json);
}
