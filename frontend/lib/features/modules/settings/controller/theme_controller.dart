import 'package:get/get.dart';
import 'package:rebar_counter/utils/theme/theme.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
        isDarkMode.value ? MyAppTheme.darkTheme : MyAppTheme.lightTheme);
  }
}
