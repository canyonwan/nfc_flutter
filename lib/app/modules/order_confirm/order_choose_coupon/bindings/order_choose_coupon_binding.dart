import 'package:get/get.dart';

import '../controllers/order_choose_coupon_controller.dart';

class OrderChooseCouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderChooseCouponController>(
      () => OrderChooseCouponController(),
    );
  }
}
