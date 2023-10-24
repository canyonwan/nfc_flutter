import 'package:get/get.dart';

import '../controllers/my_refund_order_detail_controller.dart';

class MyRefundOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRefundOrderDetailController>(
      () => MyRefundOrderDetailController(),
    );
  }
}
