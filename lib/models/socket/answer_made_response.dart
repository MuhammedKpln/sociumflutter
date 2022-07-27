import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_made_response.freezed.dart';
part 'answer_made_response.g.dart';

@freezed
class AnswerMadeResponse with _$AnswerMadeResponse {
  factory AnswerMadeResponse(
      {required String uuid,
      required Map<String, dynamic> answer}) = _AnswerMadeResponse;

  factory AnswerMadeResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerMadeResponseFromJson(json);
}
