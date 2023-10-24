import 'package:get/get.dart';

import '../controllers/forget_pay_pwd_controller.dart';

class ForgetPayPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPayPwdController>(
      () => ForgetPayPwdController(),
    );
  }
}
