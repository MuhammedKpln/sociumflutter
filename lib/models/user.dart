import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String username,
    String? avatar,
    bool? blockIncomingCalls,
    String? biography,
    DateTime? birthday,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UserMetaData with _$UserMetaData {
  factory UserMetaData(
      {required int followers,
      required int followings,
      required int rooms}) = _UserMetaData;

  factory UserMetaData.fromJson(Map<String, dynamic> json) =>
      _$UserMetaDataFromJson(json);
}
