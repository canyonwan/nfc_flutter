import 'package:get/get.dart';

import '../controllers/guess_like_controller.dart';

class GuessLikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GuessLikeController>(
      () => GuessLikeController(),
    );
  }
}
