import 'package:get/get.dart';

import '../controllers/my_dislikes_controller.dart';

class MyDislikesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDislikesController>(
      () => MyDislikesController(),
    );
  }
}
