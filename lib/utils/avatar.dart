import 'dart:math';

import 'package:scflutter/serivces.dart';

String generateAvatarUrl(String avatarPath) {
  return "${ApiService.SupabaseUrl.path}/storage/v1/object/public/${avatarPath}png";
}

String generateRandomAvatar() {
  final randomNumber = Random().nextInt(47) + 1;
  final randomAvatar = 'avatar$randomNumber';

  return randomAvatar;
}
