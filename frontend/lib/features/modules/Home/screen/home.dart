import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rebar_counter/features/modules/Home/controller/image_pick_controller.dart';
import 'package:rebar_counter/features/modules/Home/screen/widgets/custom_card.dart';
import 'package:rebar_counter/features/modules/settings/settings.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:rebar_counter/utils/constants/size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagePickController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("Dashboard",
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () => Get.to(const SettingsScreen()),
                icon: Icon(
                  CupertinoIcons.person,
                  size: 30,
                ),
              ))
        ],
        elevation: 10,
      ),
      body: Container(
        width: double.infinity,
        color: mycolors.grey.withOpacity(0.5),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: ScreenSizes.lg),
                CustomCard(
                    icon: Iconsax.gallery,
                    cardText: "Upload Photo \nFrom Gallery",
                    onPressed: () => controller.getGalleryImage()),
                const SizedBox(height: ScreenSizes.sm),
                CustomCard(
                    icon: Iconsax.camera,
                    cardText: "Capture New \nPhoto",
                    onPressed: () => controller.getCameraImage())
              ],
            )),
      ),
    );
  }
}
