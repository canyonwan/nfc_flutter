import 'package:get/get.dart';

import '../controllers/balance_use_record_list_controller.dart';

class BalanceUseRecordListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceUseRecordListController>(
      () => BalanceUseRecordListController(),
    );
  }
}
