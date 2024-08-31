import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final pref = await SharedPreferences.getInstance();
    final isLoggedIn = pref.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      Timer(
          Duration(
            seconds: 3,
          ),
          () => Get.offNamed("/home"));
    } else {
      Timer(Duration(seconds: 3), () => Get.offNamed("/signin"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logos/rebar-concrete-construction-logo-design-vector-business-architecture_765398-199-01.png",
              color: mycolors.primary,
              height: 250,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
