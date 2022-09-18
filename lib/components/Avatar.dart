import 'package:flutter/material.dart';
import 'package:scflutter/utils/avatar.dart';
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
      {Key? key,
      this.username,
      this.avatarPath,
      this.avatarSize = AvatarSize.small})
      : super(key: key);

  final String? username;
  final String? avatarPath;
  final AvatarSize avatarSize;

  Widget _renderAvatar(BuildContext context) {
    final bool isLargeAvatar = avatarSize == AvatarSize.large;

    if (avatarPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          generateAvatarUrl(avatarPath!),
          fit: BoxFit.cover,
          height: avatarSize.size,
          width: avatarSize.size,
        ),
      );
    }

    return Text(
      username![0],
      style: isLargeAvatar ? Theme.of(context).textTheme.headlineSmall : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: avatarSize.size,
      height: avatarSize.size,
      decoration: BoxDecoration(
          gradient: ColorPalette.bgLinearGradient,
          borderRadius:
              avatarSize != AvatarSize.extraSmall && avatarPath != null
                  ? BorderRadius.circular(10)
                  : BorderRadius.circular(5)),
      child: Center(child: _renderAvatar(context)),
    );
  }
}
