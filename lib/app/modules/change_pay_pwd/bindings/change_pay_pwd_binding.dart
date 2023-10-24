import 'package:get/get.dart';

import '../controllers/change_pay_pwd_controller.dart';

class ChangePayPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePayPwdController>(
      () => ChangePayPwdController(),
    );
  }
}
