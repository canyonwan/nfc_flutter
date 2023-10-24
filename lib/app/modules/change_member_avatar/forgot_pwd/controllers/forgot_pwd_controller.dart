import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

class ForgotPwdController extends GetxController {
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController codeTextEditingController = TextEditingController();
  TextEditingController newTextEditingController = TextEditingController();
  TextEditingController confirmTextEditingController = TextEditingController();

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
    _timer.cancel();
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

  Future<void> onSubmit() async {
    String phone = phoneTextEditingController.text;
    String code = codeTextEditingController.text;
    String pwd = newTextEditingController.text;
    String rePwd = confirmTextEditingController.text;
    if (phone != '' && code != '' && pwd != '' && rePwd != '') {
      final res = await memberProvider.setNewPwd(
          phone: phone, code: code, newpassword: pwd, repassword: rePwd);
      showToast('${res.msg}');
      if (res.code == 200) Get.back();
    } else {
      showToast('请填写完整信息');
    }
  }
}
