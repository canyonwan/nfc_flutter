import 'package:get/get.dart';

import '../controllers/health_butler_controller.dart';

class HealthButlerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthButlerController>(
      () => HealthButlerController(),
    );
  }
}
