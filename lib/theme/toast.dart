// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/utils/palette.dart';

enum ToastType {
  Error(ColorPalette.red),
  Success(ColorPalette.green),
  Info(ColorPalette.primary);

  final Color color;
  const ToastType(this.color);
}

class Toast {
  const Toast();

  showToast(String text,
      {ToastType? toastType = ToastType.Info, SnackBarAction? action}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: toastType?.color ?? ColorPalette.primary,
      action: action,
    ));
  }
}
