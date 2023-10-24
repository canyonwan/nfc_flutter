import 'package:get/get.dart';

import '../controllers/image_text_upload_controller.dart';

class ImageTextUploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageTextUploadController>(
      () => ImageTextUploadController(),
    );
  }
}
