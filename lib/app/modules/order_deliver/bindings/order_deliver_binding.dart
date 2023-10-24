import 'package:get/get.dart';

import '../controllers/order_deliver_controller.dart';

class OrderDeliverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDeliverController>(
      () => OrderDeliverController(),
    );
  }
}
