import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';

enum AvatarSize {
  extraSmall(20),
  small(30),
  mediumish(40),
  medium(50),
  large(100);

  final double size;

  const AvatarSize(this.size);
}

class Avatar extends StatelessWidget {
  const Avatar(
      {Key? key, required this.username, this.avatarSize = AvatarSize.small})
      : super(key: key);

  final String username;
  final AvatarSize avatarSize;

  @override
  Widget build(BuildContext context) {
    final bool isLargeAvatar = avatarSize == AvatarSize.large;

    return Container(
      width: avatarSize.size,
      height: avatarSize.size,
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
