import 'package:get/get.dart';

import '../controllers/order_payment_controller.dart';

class OrderPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderPaymentController>(
      () => OrderPaymentController(),
    );
  }
}
