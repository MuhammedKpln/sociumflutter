import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:shimmer/shimmer.dart';

import 'Avatar.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: ColorPalette.shimmerGradient,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(20 / 2),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 50}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: ColorPalette.shimmerGradient,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class AvatarSkeleton extends StatelessWidget {
  const AvatarSkeleton({Key? key, this.avatarSize = AvatarSize.medium})
      : super(key: key);

  final AvatarSize? avatarSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: ColorPalette.shimmerGradient,
      child: Container(
        height: avatarSize?.size,
        width: avatarSize?.size,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            borderRadius: avatarSize != AvatarSize.extraSmall
                ? BorderRadius.circular(10)
                : BorderRadius.circular(5)),
      ),
    );
  }
}
