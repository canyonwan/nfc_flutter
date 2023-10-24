import 'package:get/get.dart';

import '../controllers/my_notice_list_controller.dart';

class MyNoticeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyNoticeListController>(
      () => MyNoticeListController(),
    );
  }
}
