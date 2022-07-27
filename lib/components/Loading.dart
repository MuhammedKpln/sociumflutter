import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset("assets/animations/loading.json",
        repeat: true, animate: true, frameRate: FrameRate.max);
  }
}
