import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/theme/animations.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Animations.loading.path,
        repeat: true, animate: true, frameRate: FrameRate.max);
  }
}
