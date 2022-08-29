// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:scflutter/utils/palette.dart';

const SociumChatTheme = DarkChatTheme(
    backgroundColor: ColorPalette.background,
    primaryColor: ColorPalette.primary,
    secondaryColor: ColorPalette.surface,
    inputBackgroundColor: ColorPalette.surface);

SociumTheme(BuildContext context) {
  return ThemeData(
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
          backgroundColor: ColorPalette.background,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey)),
      scaffoldBackgroundColor: ColorPalette.background,
      primaryColor: ColorPalette.primary,
      buttonTheme: ButtonThemeData(
          buttonColor: ColorPalette.primary,
          padding: const EdgeInsets.all(15),
          textTheme: ButtonTextTheme.normal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ColorPalette.primary),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))))),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorPalette.background,
          selectedIconTheme: const IconThemeData(color: ColorPalette.primary),
          unselectedItemColor: Colors.grey.shade500),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
      snackBarTheme:
          const SnackBarThemeData(backgroundColor: ColorPalette.primary),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(ColorPalette.grey),
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: ColorPalette.grey,
              )))),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorPalette.primary),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
      dividerColor: Colors.grey.shade700);
}
