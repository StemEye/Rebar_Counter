import 'package:flutter/material.dart';
import 'package:rebar_counter/utils/constants/size.dart';
import '../constants/colors.dart';

/* -- Light & Dark Elevated Button Themes -- */
class MyElevatedButtonTheme {
  MyElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: mycolors.light,
      backgroundColor: mycolors.primary,
      disabledForegroundColor: mycolors.darkGrey,
      disabledBackgroundColor: mycolors.buttonDisabled,
      side: const BorderSide(color: mycolors.primary),
      padding: const EdgeInsets.symmetric(vertical: ScreenSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: mycolors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: mycolors.light,
      backgroundColor: mycolors.primary,
      disabledForegroundColor: mycolors.darkGrey,
      disabledBackgroundColor: mycolors.darkerGrey,
      side: const BorderSide(color: mycolors.primary),
      padding: const EdgeInsets.symmetric(vertical: ScreenSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: mycolors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenSizes.buttonRadius)),
    ),
  );
}
