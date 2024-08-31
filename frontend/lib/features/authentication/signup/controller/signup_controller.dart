import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;

  // Key for form validation
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Signup function
  Future<void> signup() async {
    try {
      // Check internet connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        // Display custom SnackBar using ScaffoldMessenger
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Register user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      // Save user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email.text.trim(),
        'createdAt': Timestamp.now(),
      });

      final pref = await SharedPreferences.getInstance();
      pref.setString("Email", email.text.trim());
      pref.setString("Password", password.text.trim());
      pref.setBool("isLoggedIn", true);
      // Navigate to the home screen or show a success message
      Get.offNamed('/home');
      Get.snackbar("congratulation!", "user created sucessfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.2));
    } catch (e) {
      Get.snackbar(
        "Oh snap",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
    }
  }
}
