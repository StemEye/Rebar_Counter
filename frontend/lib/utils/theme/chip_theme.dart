import 'package:flutter/material.dart';
import '../constants/colors.dart';

class MyChipTheme {
  MyChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: mycolors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: mycolors.black),
    selectedColor: mycolors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: mycolors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: mycolors.darkerGrey,
    labelStyle: TextStyle(color: mycolors.white),
    selectedColor: mycolors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: mycolors.white,
  );
}
