import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_made_response.freezed.dart';
part 'call_made_response.g.dart';

@freezed
class CallMadeResponse with _$CallMadeResponse {
  factory CallMadeResponse(
      {required String uuid,
      required Map<String, dynamic> offer}) = _CallMadeResponse;

  factory CallMadeResponse.fromJson(Map<String, dynamic> json) =>
      _$CallMadeResponseFromJson(json);
}
