import 'package:get/get.dart';

import '../controllers/my_gift_card_controller.dart';

class MyGiftCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyGiftCardController>(
      () => MyGiftCardController(),
    );
  }
}
