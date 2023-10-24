import 'dart:async';

import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  final appBarStatusText = "".obs;
  late final Timer timer;
  double nowUnixTime = 100;

  @override
  void onInit() {
    super.onInit();
    launchTimer();
  }

  void launchTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (value) {
      nowUnixTime--;
      if (nowUnixTime <= 0) {
        timer.cancel();
      }
      paraseTime(nowUnixTime);
    });
  }

  void paraseTime(double difference) {
    int minute = difference ~/ 60;
    int sec = (difference % 60).toInt();
    appBarStatusText.value = "等待付款 ${minute}分钟${sec}秒";
    print(appBarStatusText);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
  }
}
