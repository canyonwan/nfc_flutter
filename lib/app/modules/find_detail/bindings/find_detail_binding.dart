import 'package:get/get.dart';

import '../controllers/find_detail_controller.dart';

class FindDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FindDetailController>(
          () => FindDetailController(),
    );
  }
}