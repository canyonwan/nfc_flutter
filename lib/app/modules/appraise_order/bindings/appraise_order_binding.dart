import 'package:get/get.dart';

import '../controllers/appraise_order_controller.dart';

class AppraiseOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppraiseOrderController>(
      () => AppraiseOrderController(),
    );
  }
}
