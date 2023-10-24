import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/login/controllers/login_controller.dart';

class LoginClosedMiddleware extends GetMiddleware {
  @override
  void onPageDispose() {
    super.onPageDispose();
    final LoginController _loginController = Get.find<LoginController>();
    Future.delayed(Duration.zero, () {
      _loginController.toFarm();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _loginController.toFarm();
    // });
  }
}
