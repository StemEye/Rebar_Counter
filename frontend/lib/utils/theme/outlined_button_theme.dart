import 'package:flutter/material.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import '../constants/size.dart';

/* -- Light & Dark Outlined Button Themes -- */
class MyOutlinedButtonTheme {
  MyOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: mycolors.dark,
      side: const BorderSide(color: mycolors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: mycolors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: ScreenSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: mycolors.light,
      side: const BorderSide(color: mycolors.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: mycolors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(
          vertical: ScreenSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenSizes.buttonRadius)),
    ),
  );
}
