import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class HealthButlerController extends GetxController {
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  TextEditingController textEditingController = TextEditingController();

  String content = '';

  @override
  void onInit() {
    content = Get.arguments ?? '';
    textEditingController.text = content;
    super.onInit();
  }

  Future<void> onSubmit() async {
    final res = await memberProvider.editHealth(content);
    showToast('${res.msg}');
  }
}
