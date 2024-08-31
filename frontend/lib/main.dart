import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebar_counter/app.dart';
import 'package:rebar_counter/firebase_options.dart';

import 'data/repo/auth_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthRepository()));

  runApp(App());
}

// class AuthCheck extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<User?>(
//       future: SigninScreen()?? container,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasData) {
//           return HomeScreen(); // Replace with your home screen
//         } else {
//           return SigninScreen(); // Replace with your signin screen
//         }
//       },
//     );
//   }
// }
