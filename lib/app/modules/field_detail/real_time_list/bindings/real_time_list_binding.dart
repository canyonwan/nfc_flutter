import 'package:get/get.dart';

import '../controllers/real_time_list_controller.dart';

class RealTimeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealTimeListController>(
      () => RealTimeListController(),
    );
  }
}
