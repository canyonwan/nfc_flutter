import 'package:get/get.dart';

import '../controllers/set_pay_pwd_controller.dart';

class SetPayPwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPayPwdController>(
          () => SetPayPwdController(),
    );
  }
}
