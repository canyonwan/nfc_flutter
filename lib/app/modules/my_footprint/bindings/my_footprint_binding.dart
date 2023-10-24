import 'package:get/get.dart';

import '../controllers/my_footprint_controller.dart';

class MyFootprintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFootprintController>(
      () => MyFootprintController(),
    );
  }
}
