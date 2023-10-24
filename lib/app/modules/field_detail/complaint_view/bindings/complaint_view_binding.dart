import 'package:get/get.dart';

import '../controllers/complaint_view_controller.dart';

class ComplaintViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintViewController>(
      () => ComplaintViewController(),
    );
  }
}
