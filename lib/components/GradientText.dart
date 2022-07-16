import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    this.style,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(colors: [
        ColorPalette.primary,
        Colors.orange.shade300,
      ]).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
