import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentTextEditingController = TextEditingController();
  TextEditingController newTextEditingController = TextEditingController();
  TextEditingController confirmTextEditingController = TextEditingController();

  MemberProvider memberProvider = Get.find<MemberProvider>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onChangePwd() async {
    final res = await memberProvider.changePwd(
      password: currentTextEditingController.text,
      newpassword: newTextEditingController.text,
      repassword: confirmTextEditingController.text,
    );
    showToast(res.msg);
  }
}
