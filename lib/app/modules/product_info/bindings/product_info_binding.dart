import 'package:get/get.dart';

import '../controllers/product_info_controller.dart';
import '../providers/product_info_provider.dart';

class ProductInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductInfoController>(
      () => ProductInfoController(),
    );
    Get.put(ProductInfoProvider());
  }
}
