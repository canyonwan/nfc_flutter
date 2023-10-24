import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/change_phone_controller.dart';

class ChangePhoneView extends GetView<ChangePhoneController> {
  const ChangePhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('更换手机号'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
              decoration: BoxDecoration(
                color: kBgGreyColor,
                borderRadius: BorderRadius.circular(7.w),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.phoneTextEditingController,
                      decoration: InputDecoration(
                        hintText: '手机号',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Obx(() => GFButton(
                        onPressed: controller.startCountdownTimer,
                        shape: GFButtonShape.pills,
                        text: controller.countText.value,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        color: kAppColor,
                      )),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
              decoration: BoxDecoration(
                color: kBgGreyColor,
                borderRadius: BorderRadius.circular(7.w),
              ),
              child: TextField(
                controller: controller.codeTextEditingController,
                decoration: InputDecoration(
                  hintText: '短信验证码',
                  border: InputBorder.none,
                ),
              ),
            ),
            GFButton(
              shape: GFButtonShape.pills,
              color: kAppColor,
              fullWidthButton: true,
              onPressed: controller.onChangePhone,
              text: '立即更换',
            ),
          ],
        ),
      ),
    );
  }
}
