import 'package:get/get.dart';

import '../controllers/my_vip_controller.dart';

class MyVipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVipController>(
      () => MyVipController(),
    );
  }
}
