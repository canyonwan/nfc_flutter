import 'package:get/get.dart';

import '../controllers/my_webview_controller.dart';

class MyWebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWebviewController>(
      () => MyWebviewController(),
    );
  }
}
