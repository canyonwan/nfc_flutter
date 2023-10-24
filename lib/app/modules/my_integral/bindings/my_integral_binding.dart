import 'package:get/get.dart';

import '../controllers/my_integral_controller.dart';

class MyIntegralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyIntegralController>(
      () => MyIntegralController(),
    );
  }
}
