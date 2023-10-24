import 'package:get/get.dart';

import '../controllers/share_detail_controller.dart';

class ShareDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareDetailController>(
      () => ShareDetailController(),
    );
  }
}
