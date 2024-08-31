import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/features/modules/settings/controller/theme_controller.dart';
import 'package:rebar_counter/features/modules/settings/widgets/setting_item.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:rebar_counter/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();

    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: dark ? mycolors.white : mycolors.black,
            )),
        title: Text("Account menu",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Column(
        children: [
          Container(
            height: HelperFunctions.screenHeight() * 0.13,
            width: double.infinity,
            color: mycolors.primary,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: mycolors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Usama",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: mycolors.secondary),
                          ),
                          Text(
                            "usama@gmail.com",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: mycolors.secondary),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SettingItem(
              icon: CupertinoIcons.person,
              title: "User Profile",
              onPressed: () {}),
          SettingItem(
              icon: CupertinoIcons.shield,
              title: "Privacy Policy",
              onPressed: () {}),
          SettingItem(
              icon: CupertinoIcons.doc_chart_fill,
              title: "Terms of use",
              onPressed: () {}),
          SettingItem(icon: Icons.share, title: "Share", onPressed: () {}),
          SettingItem(
              icon: CupertinoIcons.phone,
              title: "Contact us",
              onPressed: () {}),
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text("Light and Dark"),
            trailing: Obx(() => IconButton(
                onPressed: () => controller.toggleTheme(),
                icon: Icon(controller.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode))),
          ),
          SettingItem(
              icon: CupertinoIcons.square_arrow_right,
              title: "Sign out",
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.setBool('isLoggedIn', false);
                Get.offNamed('/signin');
              })
        ],
      ),
    );
  }
}
