import 'package:flutter/material.dart';
import 'package:nil/nil.dart';
import 'package:scflutter/utils/palette.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, required this.child, required this.onPressed, this.style})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  factory RoundedButton.icon(
      {required VoidCallback onPressed,
      required Widget icon,
      required Widget label,
      ButtonStyle? style}) {
    return _RoundedIconButton(
        label: label, onPressed: onPressed, icon: icon, style: style);
  }

  factory RoundedButton.loading(
      {required VoidCallback onPressed,
      required bool isLoading,
      required Widget child,
      ButtonStyle? style}) {
    if (isLoading) {
      return _RoundedLoadingButton(
        onPressed: onPressed,
        style: style,
        child: child,
      );
    }

    return RoundedButton(onPressed: onPressed, child: child);
  }

  @override
  Widget build(BuildContext context) {
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

class _RoundedIconButton extends RoundedButton {
  _RoundedIconButton(
      {required super.onPressed,
      required this.label,
      required this.icon,
      super.style})
      : super(child: nil);

  Widget label;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Align(
                alignment: Alignment.center,
                child: label,
              )
            ],
          ),
        ));
  }
}

class _RoundedLoadingButton extends RoundedButton {
  const _RoundedLoadingButton(
      {required super.onPressed, required Widget child, super.style})
      : super(child: child);

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onPressed: onPressed,
      style: super.style,
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
