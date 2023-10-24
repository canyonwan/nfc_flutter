import 'package:get/get.dart';

import '../controllers/order_confirm_controller.dart';
import '../providers/order_confirm_provider.dart';

class OrderConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderConfirmController>(
      () => OrderConfirmController(),
    );
    Get.put(OrderConfirmProvider());
  }
}
