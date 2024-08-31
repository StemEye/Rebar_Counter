import 'package:flutter/material.dart';
import 'package:rebar_counter/utils/constants/colors.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text:
                  "By clicking on signin, you agree to Agree to Rebar Counter's ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: mycolors.grey)),
          TextSpan(
              text: "Terms",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: mycolors.primary)),
          TextSpan(
              text: " and ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: mycolors.grey)),
          TextSpan(
              text: "Condition of use",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: mycolors.primary)),
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
