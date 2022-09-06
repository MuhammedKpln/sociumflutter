import 'package:flutter/material.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Skeleton.dart';

enum LoadingType { list, singleLine, circle, avatar }

class LoadingNew extends StatelessWidget {
  const LoadingNew({Key? key}) : super(key: key);

  factory LoadingNew.listSkeleton() {
    return const _LoadingListShimmer();
  }
  factory LoadingNew.singleLine({double? width = 50, double? heigth}) {
    return _SingleLineSkeleton(
      width: width,
      heigth: heigth,
    );
  }
  factory LoadingNew.avatar({AvatarSize? size = AvatarSize.medium}) {
    return _AvatarShimmer(
      size: size,
    );
  }

  factory LoadingNew.circle({AvatarSize? size = AvatarSize.medium}) {
    return _AvatarShimmer(
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row();
  }
}

class _LoadingListShimmer extends LoadingNew {
  const _LoadingListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 1.5;

    return Row(
      children: [
        const CircleSkeleton(),
        Column(
          children: [
            Skeleton(
              width: screenWidth,
            ),
            Container(
              height: 20,
            ),
            Skeleton(
              width: screenWidth,
            )
          ],
        ),
      ],
    );
  }
}

class _SingleLineSkeleton extends LoadingNew {
  _SingleLineSkeleton({Key? key, this.heigth, this.width}) : super(key: key);

  double? width;
  double? heigth;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      width: width,
      height: heigth,
    );
  }
}

class _AvatarShimmer extends LoadingNew {
  _AvatarShimmer({Key? key, this.size}) : super(key: key);

  AvatarSize? size;

  @override
  Widget build(BuildContext context) {
    return AvatarSkeleton(
      avatarSize: size,
    );
  }
}

class _CircleShimmer extends LoadingNew {
  _CircleShimmer({Key? key, this.size}) : super(key: key);

  double? size;

  @override
  Widget build(BuildContext context) {
    return CircleSkeleton(size: size);
  }
}
