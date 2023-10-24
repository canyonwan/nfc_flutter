import 'package:get/get.dart';

import '../controllers/change_member_name_controller.dart';

class ChangeMemberNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeMemberNameController>(
      () => ChangeMemberNameController(),
    );
  }
}
