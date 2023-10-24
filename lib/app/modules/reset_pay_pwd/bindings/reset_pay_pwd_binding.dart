import 'package:get/get.dart';

import '../controllers/reset_pay_pwd_controller.dart';

class ResetPayPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPayPwdController>(
      () => ResetPayPwdController(),
    );
  }
}
