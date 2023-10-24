import 'package:get/get.dart';

import '../controllers/change_phone_controller.dart';

class ChangePhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePhoneController>(
      () => ChangePhoneController(),
    );
  }
}
