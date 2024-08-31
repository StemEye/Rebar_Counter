import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rebar_counter/features/authentication/signup/controller/signup_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;

  //key of form validation
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  Future<void> signin() async {
    try {
      //formvalidation
      if (!signinFormKey.currentState!.validate()) {
        return;
      }

      //signin with firebase auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        final pref = await SharedPreferences.getInstance();
        pref.setString("Email", email.text.trim());
        pref.setString("Password", password.text.trim());
        pref.setBool("isLoggedIn", true);
        Get.offNamed('/home');
      } else {
        Get.snackbar("oh snap", "User not found",
            backgroundColor: Colors.orange,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("oh snap!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2));
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //create new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Sign in to Firebase with the Google user credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Save user data to Firestore
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          // Save user information to Firestore
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set({
            "name": user.displayName,

            "email": user.email,
            "uid": user.uid,
            // "photoUrl": user.photoURL,
          });

          // } else {
          //   Get.snackbar(
          //       "oh snap!", "Login detail not found, please creat new account",
          //       snackPosition: SnackPosition.BOTTOM,
          //       backgroundColor: Colors.red.withOpacity(0.2));
        }

        // Navigate to home
        final pref = await SharedPreferences.getInstance();
        pref.setString("Email", email.text.trim());
        pref.setString("Password", password.text.trim());
        pref.setString("name", user.displayName.toString());
        pref.setBool("isLoggedIn", true);
        Get.offNamed('/home');
      }
    } catch (e) {
      Get.snackbar("oh snap!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2));
    }
  }
}
