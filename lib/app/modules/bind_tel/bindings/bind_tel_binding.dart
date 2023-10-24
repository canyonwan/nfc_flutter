import 'package:get/get.dart';

import '../controllers/bind_tel_controller.dart';

class BindTelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindTelController>(
          () => BindTelController(),
    );
  }
}
