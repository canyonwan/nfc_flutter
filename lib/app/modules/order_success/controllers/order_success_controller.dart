import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';

class OrderSuccessController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onToOrderList() async {
    Get.offAllNamed(Routes.ROOT);
    Get.toNamed(Routes.MY_ORDER, arguments: {'type': 3});
  }

  void onToRootPage() {
    Get.offAllNamed(Routes.ROOT, arguments: {'showSplash': false});
  }
}
