import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';

class ChangeMemberNameController extends GetxController {
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  TextEditingController textEditingController = TextEditingController();

  String name = '';

  @override
  void onInit() {
    textEditingController.text = Get.arguments.toString();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> onSubmit() async {
    EasyLoading.show();
    final res = await memberProvider.changeUsername(name);
    if (res.code == 200 && res.data != null) {
      EasyLoading.showSuccess('${res.msg}');
      Get.back(result: res.data!.memberName);
    }
  }
}
