import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/features/modules/imagedisplay/controller/custom_painter.dart';
import 'package:rebar_counter/features/modules/imagedisplay/controller/rebar_conter_controller.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:rebar_counter/utils/constants/size.dart';
import 'package:rebar_counter/utils/helpers/helper_functions.dart';

class ImageDisplayScreen extends StatelessWidget {
  ImageDisplayScreen({super.key, required this.imagePath});
  final String imagePath;
  final controller = Get.put(RebarController());

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: ScreenSizes.lg),
              Image.file(
                File(imagePath),
                fit: BoxFit.contain,
                height: HelperFunctions.screenHeight() * 0.6,
                width: double.infinity,
              ),
              Spacer(),
              Container(
                height: HelperFunctions.screenHeight() * 0.1,
                width: double.infinity,
                color: dark ? mycolors.secondary : mycolors.black,
                child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(130, 50),
                            elevation: 0,
                            backgroundColor: mycolors.primary),
                        onPressed: () {
                          print("Count button pressed");

                          controller.countRebar(File(imagePath));
                        },
                        child: Text(
                          "Count",
                          style: Theme.of(context).textTheme.titleLarge,
                        ))),
              ),
            ],
          ),
          Obx(() {
            if (controller.rebarCount.value > 0) {
              return CustomPaint(
                painter:
                    RebarPainter(rebarPositions: controller.rebarPositions),
                child: Container(),
              );
            }
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
