import 'package:flutter/material.dart';
import 'package:rebar_counter/utils/constants/size.dart';

import '../constants/colors.dart';

class MyAppBarTheme {
  MyAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: mycolors.black, size: ScreenSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: mycolors.black, size: ScreenSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: mycolors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: mycolors.black, size: ScreenSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: mycolors.white, size: ScreenSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: mycolors.white),
  );
}
