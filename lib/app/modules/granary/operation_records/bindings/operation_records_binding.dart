import 'package:get/get.dart';

import '../controllers/operation_records_controller.dart';

class OperationRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperationRecordsController>(
      () => OperationRecordsController(),
    );
  }
}
