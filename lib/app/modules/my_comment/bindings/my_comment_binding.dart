import 'package:get/get.dart';

import '../controllers/my_comment_controller.dart';

class MyCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCommentController>(
      () => MyCommentController(),
    );
  }
}
