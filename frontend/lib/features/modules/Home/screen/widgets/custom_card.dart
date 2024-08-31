import 'package:flutter/material.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:rebar_counter/utils/constants/size.dart';
import 'package:rebar_counter/utils/helpers/helper_functions.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.icon,
      required this.cardText,
      required this.onPressed});

  final IconData icon;
  final String cardText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 10,
        color: dark ? mycolors.black : mycolors.white,
        child: Container(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: dark
                        ? mycolors.darkGrey.withOpacity(0.15)
                        : mycolors.grey.withOpacity(0.5),
                  ),
                  child: Icon(
                    icon,
                    color: mycolors.primary,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: ScreenSizes.sm),
              Text(cardText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: dark ? mycolors.white : mycolors.black))
            ],
          ),
        ),
      ),
    );
  }
}
