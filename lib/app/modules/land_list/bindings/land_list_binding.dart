import 'package:get/get.dart';

import '../controllers/land_list_controller.dart';

class LandListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandListController>(
      () => LandListController(),
    );
  }
}
