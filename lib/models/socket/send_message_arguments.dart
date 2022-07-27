import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:scflutter/models/user_model.dart';

part 'send_message_arguments.freezed.dart';
part 'send_message_arguments.g.dart';

@freezed
abstract class SendMessageArguments with _$SendMessageArguments {
  const factory SendMessageArguments({
    required String room,
    required String message,
    required User user,
    required User receiver,
    int? repliedToId,
  }) = _SendMessageArguments;

  factory SendMessageArguments.fromJson(Map<String, dynamic> json) =>
      _$SendMessageArgumentsFromJson(json);
}
