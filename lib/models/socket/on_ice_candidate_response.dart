import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_ice_candidate_response.freezed.dart';
part 'on_ice_candidate_response.g.dart';

@freezed
class OnIceCandidateResponse with _$OnIceCandidateResponse {
  factory OnIceCandidateResponse(
      {required Map<String, dynamic> candidate,
      required String uuid}) = _OnIceCandidateResponse;

  factory OnIceCandidateResponse.fromJson(Map<String, dynamic> json) =>
      _$OnIceCandidateResponseFromJson(json);
}
