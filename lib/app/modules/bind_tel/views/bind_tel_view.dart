import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/modules/bind_tel/controllers/bind_tel_controller.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/bind_tel_controller.dart';

class BindTelView extends GetView<BindTelController> {
  const BindTelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('绑定手机号'), centerTitle: true),
      body:   Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(4.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: controller.usernameController,
                      maxLines: 1,
                      autofocus: true,
                      cursorWidth: 1,
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "请输入手机号",
                        labelText: "enter_username".tr,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: GFButton(
                        shape: GFButtonShape.pills,
                        borderSide:
                        BorderSide(width: 1, color: kAppGrey66Color),
                        onPressed: controller.getVerification,
                        color: kBgGreyColor,
                        textColor: kAppGrey66Color,
                        text: '获取验证码',
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(4.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                controller: controller.verificationController,
                maxLines: 1,
                autofocus: true,
                cursorWidth: 1,
                cursorColor: Colors.red,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "enter_verification".tr,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 30),
            Obx(
                  () => GFButton(
                onPressed: () {
                  if (controller.isRegistering.isFalse) {
                    controller.onRegister();
                  }
                },
                blockButton: true,
                text: controller.isRegistering.isFalse ? "register".tr : '请稍候',
                color: kAppColor,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
