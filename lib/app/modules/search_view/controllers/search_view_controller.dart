import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  BrnSearchTextController searchController = BrnSearchTextController();
  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    textController.text = Get.arguments ?? '';
    super.onInit();
  }
}
