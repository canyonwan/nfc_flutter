import 'package:get/get.dart';

import '../controllers/real_time_player_controller.dart';

class RealTimePlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealTimePlayerController>(
      () => RealTimePlayerController(),
    );
  }
}
