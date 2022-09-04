import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            gradient: ColorPalette.surfaceLinearGradient,
            borderRadius: BorderRadius.circular(20)),
        child: child);
  }
}
