import 'package:get/get.dart';

import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';

class Vr360Controller extends GetxController {
  List<VRItemModel> vrList = [];
  String currentUrl = '';

  @override
  void onInit() {
    vrList = Get.arguments['list'];
    if (vrList.isNotEmpty) currentUrl = vrList.first.image!;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeVRUrl(String url) {
    currentUrl = url;
    update();
  }
}
