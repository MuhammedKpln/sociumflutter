import 'package:scflutter/serivces.dart';

String generateAvatarUrl(String avatarPath) {
  return "${ApiService.SupabaseUrl.path}/storage/v1/object/public/$avatarPath";
}
