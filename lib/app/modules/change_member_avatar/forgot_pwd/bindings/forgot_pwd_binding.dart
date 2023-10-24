import 'package:get/get.dart';

import '../controllers/forgot_pwd_controller.dart';

class ForgotPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPwdController>(
      () => ForgotPwdController(),
    );
  }
}
