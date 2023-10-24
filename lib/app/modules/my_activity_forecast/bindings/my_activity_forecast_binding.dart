import 'package:get/get.dart';

import '../controllers/my_activity_forecast_controller.dart';

class MyActivityForecastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyActivityForecastController>(
      () => MyActivityForecastController(),
    );
  }
}
