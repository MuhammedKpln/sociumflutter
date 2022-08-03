import 'package:flutter/material.dart';
import 'package:scflutter/utils/palette.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.style,
      this.icon})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        icon: icon!,
        label: child,
        onPressed: onPressed,
        style: style,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0))),
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)))
          .merge(style),
      child: Ink(
        decoration: BoxDecoration(
          gradient: style == null ? ColorPalette.bgLinearGradient : null,
          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
