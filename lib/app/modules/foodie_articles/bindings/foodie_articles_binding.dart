import 'package:get/get.dart';

import '../controllers/foodie_articles_controller.dart';

class FoodieArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodieArticlesController>(
      () => FoodieArticlesController(),
    );
  }
}
