import 'package:get/get.dart';

import '../controllers/my_likes_controller.dart';

class MyLikesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLikesController>(
      () => MyLikesController(),
    );
  }
}
