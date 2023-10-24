import 'package:get/get.dart';

import '../controllers/vr360_controller.dart';

class Vr360Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Vr360Controller>(
      () => Vr360Controller(),
    );
  }
}
