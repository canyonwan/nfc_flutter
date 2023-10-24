import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ChangePhoneController extends GetxController {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController codeTextEditingController = TextEditingController();
  MemberProvider memberProvider = Get.find<MemberProvider>();
  late Timer _timer;
  RxInt countdownTime = 60.obs;
  RxString countText = '获取验证码'.obs;
  String code = '';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  Future<void> getSmsCode() async {
    String base64Username =
        SharedUtil.encodeBase64(phoneTextEditingController.text);
    String nongfucang = "nongfucang";
    String addnongfucangUsername = base64Username + nongfucang;
    String newBase64Username = SharedUtil.encodeBase64(addnongfucangUsername);
    var res = await memberProvider.getVerification(username: newBase64Username);
    if (res.code == 200) {
      showToast(res.msg);
    }
  }

  void startCountdownTimer() {
    print('length: ${phoneTextEditingController.text.length}');
    if (phoneTextEditingController.text.length == 11) {
      getSmsCode();
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (countdownTime.value == 0) {
          countText.value = '重新获取';
          _timer.cancel();
          countdownTime.value = 60;
        } else {
          countdownTime.value--;
          countText.value = '${countdownTime.value}s后获取';
        }
      });
    } else {
      showToast('请正确输入手机号');
    }
  }

  Future<void> onChangePhone() async {
    final res = await memberProvider.changePhone(
      newphone: phoneTextEditingController.text,
      code: codeTextEditingController.text,
    );
    showToast('${res.msg}');
  }
}
