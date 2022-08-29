import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';

part 'client_paired.freezed.dart';
part 'client_paired.g.dart';

@freezed
abstract class ClientPaired with _$ClientPaired {
  const factory ClientPaired({
    required Room room,
    required UserModel user,
    required String uuid,
  }) = _ClientPaired;

  factory ClientPaired.fromJson(Map<String, dynamic> json) =>
      _$ClientPairedFromJson(json);
}
