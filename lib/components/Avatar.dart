import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';

enum AvatarSize { extraSmall, small, medium, mediumish, large }

class Avatar extends StatelessWidget {
  const Avatar(
      {Key? key, required this.username, this.avatarSize = AvatarSize.small})
      : super(key: key);

  final String username;
  final AvatarSize avatarSize;

  @override
  Widget build(BuildContext context) {
    double? width;
    double? height;

    final bool isLargeAvatar = avatarSize == AvatarSize.large;

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
          username[0],
          style:
              isLargeAvatar ? Theme.of(context).textTheme.headlineSmall : null,
        ),
      ),
    );
  }
}
