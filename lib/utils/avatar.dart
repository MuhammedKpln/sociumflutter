import 'dart:math';

String generateAvatarUrl(String avatarName) {
  return "https://i.pravatar.cc/150?u=$avatarName";
}

String generateRandomAvatar() {
  final randomNumber = Random().nextInt(47) + 1;
  final randomAvatar = 'avatar$randomNumber';

  return randomAvatar;
}
