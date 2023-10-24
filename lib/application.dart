import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Application {
  static Future<void> init() async {
    await Get.putAsync(() => AppController().init());
  }
}

class AppController extends GetxService {
  Future<SharedPreferences> init() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp;
  }
}
