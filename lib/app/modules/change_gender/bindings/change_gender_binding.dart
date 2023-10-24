import 'package:get/get.dart';

import '../controllers/change_gender_controller.dart';

class ChangeGenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeGenderController>(
      () => ChangeGenderController(),
    );
  }
}
