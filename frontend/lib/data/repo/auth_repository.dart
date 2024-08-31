import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  //variabel
  final deviceStorage = GetStorage();
  // final FirebaseAuth _auth= FirebaseAuth.instance;

  //called from main dart on app launch

  // @override
  // void onReady(){
  //   FlutterNativeSplash.removeRoute(route)
  // }

  //  function to share relivent screen
  screenRedirect() async {}

  // #------------------------------- Email and password -------------------------------------#
}


  //Register

  // Future<UserCredential?> registerWithEmailAndPassword(String email, String password) async{
  //   try {
  //     return await _auth.
  //   } catch (e) {
      
  //   }
  // }


