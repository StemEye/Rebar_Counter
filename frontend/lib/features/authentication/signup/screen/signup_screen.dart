import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/commons/widget/custom_button.dart';
import 'package:rebar_counter/features/authentication/signin/controller/signin_controller.dart';
import 'package:rebar_counter/features/authentication/signin/screen/signin_screen.dart';
import 'package:rebar_counter/features/authentication/signin/screen/widgets/terms_condition.dart';
import 'package:rebar_counter/features/authentication/signup/controller/signup_controller.dart';
import 'package:rebar_counter/utils/constants/colors.dart';
import 'package:rebar_counter/utils/constants/size.dart';
import 'package:rebar_counter/utils/helpers/helper_functions.dart';
import 'package:rebar_counter/utils/validators/validator.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final googlecontroller = Get.put(SigninController());
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    const SizedBox(height: ScreenSizes.lg * 2),
                    Image.asset(
                      "assets/logos/rebar-concrete-construction-logo-design-vector-business-architecture_765398-199-01.png",
                      color: mycolors.primary,
                      height: 90,
                      width: 120,
                    ),
                    //signin with google button
                    const SizedBox(height: ScreenSizes.lg),
                    CustomButton(
                      height: 45,
                      width: double.infinity,
                      isLogoAvail: true,
                      textColor: dark ? mycolors.white : mycolors.black,
                      logo: "assets/icons/google.svg",
                      btnText: 'Sign up with google',
                      borderColor: dark ? mycolors.white : mycolors.black,
                      bgColor: dark ? mycolors.black : Colors.white,
                      onPressed: () => googlecontroller.googleSignIn(),
                    ),

                    //divider
                    const SizedBox(height: ScreenSizes.md),
                    Row(
                      children: [
                        Flexible(
                          child: Divider(
                            color:
                                dark ? mycolors.lightGrey : mycolors.darkGrey,
                            thickness: 1,
                            indent: 10,
                            endIndent: 5,
                          ),
                        ),
                        Text("Or sign up with Email",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: dark
                                          ? mycolors.lightGrey
                                          : mycolors.darkGrey,
                                    )),
                        Flexible(
                          child: Divider(
                            color:
                                dark ? mycolors.lightGrey : mycolors.darkGrey,
                            thickness: 1,
                            indent: 5,
                            endIndent: 10,
                          ),
                        ),
                      ],
                    ),

                    //fields
                    const SizedBox(height: ScreenSizes.lg),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),

                    TextFormField(
                        controller: controller.email,
                        validator: (value) => Validator.validateEmail(value),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            hintText: "Email",
                            hintStyle: TextStyle(height: 0.1),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: mycolors.primary)))),

                    const SizedBox(height: ScreenSizes.md),

                    Row(
                      children: [
                        Text(
                          "Password",
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),

                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value) => Validator.validatePassword(value),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            suffix: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: Icon(
                                controller.hidePassword.value
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                                size: 20,
                              ),
                              constraints:
                                  BoxConstraints(minHeight: 0, minWidth: 0),
                              padding: EdgeInsets.zero,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(height: 3),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: mycolors.primary))),
                      ),
                    ),

                    //Signup button
                    const SizedBox(height: ScreenSizes.md),

                    CustomButton(
                        height: 45,
                        width: double.infinity,
                        textColor: mycolors.white,
                        btnText: "Sign up",
                        borderColor: Colors.transparent,
                        bgColor: mycolors.primary.withOpacity(0.5),
                        onPressed: () => controller.signup()),

                    //terms and condition
                    const SizedBox(height: ScreenSizes.sm),
                    TermsCondition(),
                    //Divider
                    const SizedBox(height: ScreenSizes.sm),
                    Divider(
                      color: mycolors.grey,
                    ),

                    //continue as a guest button
                    const SizedBox(height: ScreenSizes.md),
                    CustomButton(
                        height: 50,
                        width: double.infinity,
                        textColor: dark ? mycolors.white : mycolors.primary,
                        btnText: "Continue as guests",
                        bgColor: dark
                            ? mycolors.grey.withOpacity(0.15)
                            : mycolors.darkGrey.withOpacity(0.15),
                        isIconAvail: true,
                        icon: Icons.arrow_forward,
                        borderColor: Colors.transparent,
                        onPressed: () => Get.offNamed('/home')),

                    //creat account
                    const SizedBox(height: ScreenSizes.lg),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already have account?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(SigninScreen()),
                          text: " Sign in",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: mycolors.primary)),
                    ]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
