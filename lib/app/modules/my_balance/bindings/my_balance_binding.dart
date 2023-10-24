import 'package:get/get.dart';

import '../controllers/my_balance_controller.dart';

class MyBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBalanceController>(
      () => MyBalanceController(),
    );
  }
}
