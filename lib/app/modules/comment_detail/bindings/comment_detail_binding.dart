import 'package:get/get.dart';

import '../controllers/comment_detail_controller.dart';

class CommentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentDetailController>(
      () => CommentDetailController(),
    );
  }
}
