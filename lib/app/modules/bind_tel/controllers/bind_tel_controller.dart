import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'package:mallxx_app/app/modules/root/controllers/account_controller.dart';

import '../../root/providers/member_provider.dart';
import '/app/providers/login_provider.dart';

class BindTelController extends GetxController {
  late TextEditingController usernameController = TextEditingController();
 // late TextEditingController passwordController = TextEditingController();
  late TextEditingController verificationController = TextEditingController();
  final LoginProvider loginProvider = Get.find<LoginProvider>();
  final AccountController accountController = Get.find<AccountController>();
  final MemberProvider memberProvider = Get.find<MemberProvider>();

  final isRegistering = false.obs;
  static const _timerDuration = 30;
  StreamController _timerStream = new StreamController<int>();
  final int timerCounter = 60;
  late Timer _resendCodeTimer;
  @override
  void onInit() {
    _timerStream.sink.add(0);
    activeCounter();
    super.onInit();
  }

  void onRegister() async {
    String username = usernameController.text;
   // String password = passwordController.text;
    String verification = verificationController.text;

    if (username == "") {
      showToast(
        "enter_username".tr,
      );
      return;
    }

    if (username.length < 6) {
      showToast(
        "enter_username".tr,
      );
      return;
    }

    if (verification == "") {
      showToast(
        "请输入验证码",
      );
      return;
    }

    isRegistering.value = true;
    var result = await memberProvider.changePhone(
        newphone: username, code: verification);

    if (result.code != null) {
      if (result.code == 200) {
        //loginProvider.saveLogin(result.data!);
        Get.back(
          result: "OK",
        );
        // accountController.setMember();
      } else {
        showToast(
          result.msg!,
        );
        isRegistering.value = false;
      }
    }
  }

  void getVerification() async {
    String username = usernameController.text;
    if (username == "") {
      showToast(
        "enter_username".tr,
      );
      return;
    }
    String base64Username = encodeBase64(username);
    String nongfucang = "nongfucang";
    String addnongfucangUsername = base64Username + nongfucang;
    String newBase64Username = encodeBase64(addnongfucangUsername);
    var result =
    await memberProvider.getVerification(username: newBase64Username);

    if (result.code != null) {
      if (result.code == 200) {
        showToast(
          "验证码发送成功",
        );
        return;
      } else {
        showToast(
          result.msg,
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  /*
  * Base64加密
  */
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  activeCounter() {
    _resendCodeTimer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0)
        _timerStream.sink.add(_timerDuration - timer.tick);
      else {
        _timerStream.sink.add(0);
        _resendCodeTimer.cancel();
      }
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _timerStream.close();
    _resendCodeTimer.cancel();
    super.dispose();
  }
}
