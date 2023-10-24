import 'package:get/get.dart';

import '/app/modules/root/controllers/account_controller.dart';
import '/app/providers/login_provider.dart';
import '/app/routes/app_pages.dart';
import '../../root/providers/member_provider.dart';

class SettingController extends GetxController {
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final AccountController accountController = Get.find<AccountController>();
  final MemberProvider memberProvider = Get.find<MemberProvider>();

  List<Map> settingsTitle = [
    {"name": "个人信息", "url": Routes.ACCOUNT_INFO},
    {"name": "address_setting".tr, "url": Routes.ADDRESS_BOOK},
    {"name": "关于农副仓".tr, "url": Routes.MY_WEBVIEW},
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void onSignOut() {
    loginProvider.cleanLogin();
    accountController.setMember();
    memberProvider.signOut();
    Get.back();
  }

  void onClick(int index) {
    if (index == 0 || index == 1) {
      if (loginProvider.isLogin() == false) {
        Get.toNamed(Routes.LOGIN);
        return;
      }
      Get.toNamed(settingsTitle[index]["url"]);
    } else {
      Get.toNamed(settingsTitle[index]["url"],
          arguments: {"type": 2, "first": "https://www.nongfucang.com/nfc"});
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
