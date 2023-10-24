import 'package:get/get.dart';
import '../controllers/shop_cart_controller.dart';

class ShopCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopCartController>(
      () => ShopCartController(),
    );
  }
}
