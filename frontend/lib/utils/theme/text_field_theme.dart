import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/size.dart';

class MyTextFormFieldTheme {
  MyTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: mycolors.darkGrey,
    suffixIconColor: mycolors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: ScreenSizes.fontSizeMd, color: mycolors.black),
    hintStyle: const TextStyle()
        .copyWith(fontSize: ScreenSizes.fontSizeSm, color: mycolors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: mycolors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: mycolors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: mycolors.darkGrey,
    suffixIconColor: mycolors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: ScreenSizes.fontSizeMd, color: mycolors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: ScreenSizes.fontSizeSm, color: mycolors.white),
    floatingLabelStyle:
        const TextStyle().copyWith(color: mycolors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: mycolors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ScreenSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: mycolors.warning),
    ),
  );
}
