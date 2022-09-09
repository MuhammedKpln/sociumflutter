import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  LottieAnimation(
      {Key? key, required this.animationPath, this.heigth, this.width})
      : super(key: key);

  String animationPath;
  double? width;
  double? heigth;

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();

    _composition = _loadComposition();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load(widget.animationPath);
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Lottie(
            composition: composition,
            frameRate: FrameRate.max,
            filterQuality: FilterQuality.medium,
            width: widget.width,
            height: widget.heigth,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
