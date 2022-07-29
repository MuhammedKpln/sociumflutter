import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_permissions_response.freezed.dart';
part 'media_permissions_response.g.dart';

@freezed
class MediaPermission with _$MediaPermission {
  factory MediaPermission({bool? audio, bool? video, required String uuid}) =
      _MediaPermission;

  factory MediaPermission.fromJson(Map<String, dynamic> json) =>
      _$MediaPermissionFromJson(json);
}
