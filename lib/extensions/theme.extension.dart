import 'package:flutter/material.dart';

extension TextStyleExtension on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}
