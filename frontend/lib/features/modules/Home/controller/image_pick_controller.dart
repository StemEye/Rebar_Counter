import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebar_counter/features/modules/imagedisplay/image_display.dart';

class ImagePickController extends GetxController {
  RxString imagePath = ''.obs;

  Future getCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      Get.to(() => ImageDisplayScreen(imagePath: image.path));

      // Image file loaded successfully
      print('Image Loaded Successfully: ${image.path}');
    } else {
      print('No image selected from camera.');
    }
  }

  Future getGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Get.to(() => ImageDisplayScreen(imagePath: image.path));

      // Image file loaded successfully
      print('Image Loaded Successfully: ${image.path}');
    } else {
      print('No image selected from camera.');
    }
  }
}
