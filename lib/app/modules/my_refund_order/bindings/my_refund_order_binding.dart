import 'package:get/get.dart';

import '../controllers/my_refund_order_controller.dart';

class MyRefundOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRefundOrderController>(
      () => MyRefundOrderController(),
    );
  }
}
