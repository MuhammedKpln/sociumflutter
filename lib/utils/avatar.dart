import 'dart:math';

String generateAvatarUrl(String avatarName) {
  return "https://derdevam.com/static/avatars/$avatarName.webp";
}

String generateRandomAvatar() {
  final randomNumber = Random().nextInt(47) + 1;
  final randomAvatar = 'avatar$randomNumber';

  return randomAvatar;
}
