import 'package:get/get.dart';

import '../../root/controllers/market_controller.dart';

class marketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketController>(
      () => MarketController(),
    );
  }
}
