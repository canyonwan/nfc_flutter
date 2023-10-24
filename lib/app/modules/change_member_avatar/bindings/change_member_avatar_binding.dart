import 'package:get/get.dart';

import '../controllers/change_member_avatar_controller.dart';

class ChangeMemberAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeMemberAvatarController>(
      () => ChangeMemberAvatarController(),
    );
  }
}
