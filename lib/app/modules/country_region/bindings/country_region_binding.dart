import 'package:get/get.dart';

import '../controllers/country_region_controller.dart';

class CountryRegionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountryRegionController>(
      () => CountryRegionController(),
    );
  }
}
