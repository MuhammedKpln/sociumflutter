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
  final Function() onPressed;
  final ButtonStyle? style;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    ButtonStyle _style = ButtonStyle(
            backgroundColor: style?.backgroundColor == null
                ? MaterialStateProperty.all(ColorPalette.primary)
                : null,
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            padding: MaterialStateProperty.all(EdgeInsets.all(15)),
            textStyle: MaterialStateProperty.all(
                TextStyle(fontWeight: FontWeight.normal, fontSize: 13)))
        .merge(style);

    if (icon != null) {
      return ElevatedButton.icon(
          icon: icon!, label: child, onPressed: onPressed, style: _style);
    }

    return ElevatedButton(
      child: child,
      onPressed: onPressed,
      style: _style,
    );
  }
}
