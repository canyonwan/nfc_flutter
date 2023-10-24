import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/routes/app_pages.dart';

class LanguageMode {
  String name;
  String language;
  String country;
  LanguageMode({
    required this.name,
    required this.country,
    required this.language,
  });
}

class LanguageController extends GetxController {
  // Locale? localeLan =

  String? languageCode =
      Get.locale!.languageCode + "-" + Get.locale!.countryCode!;

  var langugeList = [
    LanguageMode(
      language: "zh",
      country: "CN",
      name: "简体中文",
    ).obs,
    LanguageMode(
      language: "en",
      country: "US",
      name: "English",
    ).obs,
  ];

  @override
  void onInit() {
    print(languageCode);
    super.onInit();
  }

  void setSelected(int index) {
    Get.updateLocale(Locale(
        langugeList[index].value.language, langugeList[index].value.country));
    Get.offAllNamed(Routes.ROOT);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
