import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class ResetPayPwdController extends GetxController {
  MemberProvider memberProvider = Get.find<MemberProvider>();

  RxInt show = 0.obs;
  RxString current = ''.obs;
  RxString newPwd = ''.obs;
  RxString rePwd = ''.obs;

  TextEditingController nowTextEditingController = TextEditingController();
  TextEditingController newTextEditingController = TextEditingController();
  TextEditingController setTextEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void onChangeNow(String pin) {
    if (pin.length == 6) {
      current.value = pin;
      nowTextEditingController.clear();
      show.value = 1;
    }
  }

  void onChangeNew(String pin) {
    if (pin.length == 6) {
      newPwd.value = pin;
      show.value = 2;
      newTextEditingController.clear();
    }
  }

  void onChangeRe(String pin) {
    if (pin.length == 6) {
      rePwd.value = pin;
    }
  }

  Future<void> onSet() async {
    final res = await memberProvider.resetPayPwd(
      pay_pass: current.value,
      new_pay_pass: newPwd.value,
      re_pay_pass: rePwd.value,
    );
    showToast(res.msg);
  }
}
