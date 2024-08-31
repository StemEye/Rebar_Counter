import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    this.bgColor,
    required this.textColor,
    this.logo,
    required this.btnText,
    this.icon,
    required this.borderColor,
    required this.onPressed,
    this.isLogoAvail = false,
    this.isIconAvail = false,
  });

  final double height;
  final double width;
  final String? logo;
  final String btnText;
  final IconData? icon;
  final Color? bgColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final bool? isLogoAvail;
  final bool? isIconAvail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLogoAvail! && logo != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(logo!),
              ),
            Text(
              btnText,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: textColor),
            ),
            if (isIconAvail! && icon != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
