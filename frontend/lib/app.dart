import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/features/authentication/signin/screen/signin_screen.dart';
import 'package:rebar_counter/features/authentication/signup/screen/signup_screen.dart';
import 'package:rebar_counter/features/modules/Home/screen/home.dart';
import 'package:rebar_counter/features/modules/settings/controller/theme_controller.dart';
import 'package:rebar_counter/splash.dart';

import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  App({super.key});
  final controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyTexts.appName,
      themeMode: controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,

      //calling pages
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreeen()),
        GetPage(name: '/signin', page: () => const SigninScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
