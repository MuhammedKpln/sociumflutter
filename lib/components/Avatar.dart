import 'package:flutter/material.dart';
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';

enum AvatarSize { extraSmall, small, medium, mediumish, large }

class Avatar extends StatelessWidget {
  Avatar({Key? key, this.avatarName, required this.avatarSize})
      : super(key: key);

  String? avatarName;
  AvatarSize avatarSize = AvatarSize.small;

  @override
  Widget build(BuildContext context) {
    final randomAvatar = generateRandomAvatar();
    double? width;
    double? height;

    switch (avatarSize) {
      case AvatarSize.extraSmall:
        width = 20;
        height = 20;
        break;
      case AvatarSize.small:
        width = 30;
        height = 30;
        break;
      case AvatarSize.mediumish:
        width = 40;
        height = 40;
        break;
      case AvatarSize.medium:
        width = 50;
        height = 50;
        break;
      case AvatarSize.large:
        width = 100;
        height = 100;
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: ColorPalette.bgLinearGradient,
          borderRadius: avatarSize != AvatarSize.extraSmall
              ? BorderRadius.circular(10)
              : BorderRadius.circular(5)),
      child: Center(
        child: Text(
          avatarName?[0] ?? "M",
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
