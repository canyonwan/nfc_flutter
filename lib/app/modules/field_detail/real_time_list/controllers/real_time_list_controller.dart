import 'package:get/get.dart';

import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';

class RealTimeListController extends GetxController {
  String token = '';
  List<MonitorModel> list = [];

  @override
  void onInit() {
    token = Get.arguments['token'];
    list = Get.arguments['list'];
    super.onInit();
  }
}
