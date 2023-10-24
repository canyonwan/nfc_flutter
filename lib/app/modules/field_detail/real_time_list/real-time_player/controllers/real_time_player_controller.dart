import 'package:auto_orientation/auto_orientation.dart';
// import 'package:flutter_ys7/flutter_ys7.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_button_status_model.dart';

class RealTimePlayerController extends GetxController {
  MonitorModel model = MonitorModel();
  String token = '';

  @override
  void onInit() {
    model = Get.arguments['model'];
    token = Get.arguments['token'];
    if (token != '') {
      initPlayer();
    }
    super.onInit();
  }

  @override
  void onReady() {
    AutoOrientation.landscapeAutoMode();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // FlutterYs7.videoRelease();
    // FlutterYs7.destoryLib();
  }

  Future<void> initPlayer() async {
    // await FlutterYs7.setAccessToken(token);
    // bool initRes = await FlutterYs7.initEZPlayer(
    //     model.number!, '', int.parse(model.channels!));
    // if (initRes) {
    //   FlutterYs7.startRealPlay();
    // }
  }

  void exitFullScreen() {
    AutoOrientation.portraitAutoMode();
    Get.back();
  }
}
