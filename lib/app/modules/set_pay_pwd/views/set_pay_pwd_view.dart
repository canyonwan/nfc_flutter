import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../controllers/set_pay_pwd_controller.dart';

class SetPayPwdView extends GetView<SetPayPwdController> {
  const SetPayPwdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('设置支付密码'), centerTitle: true),
      // body: Obx(() => controller.show.value ? buildShow() : _buildNew()),
      body: Obx(() {
        if (controller.show.value == 0) {
          return _buildSet();
        } else {
          return buildReset();
        }
      }),
    );
  }


  Column _buildSet() {
    return Column(
      children: [
        Text('设置6位数字密码', style: TextStyle(fontSize: 18.sp))
            .paddingSymmetric(vertical: 20.h),
        PinInputTextField(
          controller: controller.newTextEditingController,
          pinLength: 6,
          decoration: BoxTightDecoration(
            strokeColor: Colors.grey,
            obscureStyle: ObscureStyle(isTextObscure: true),
          ),
          autoFocus: true,
          textInputAction: TextInputAction.go,
          enabled: true,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.characters,
          onChanged: (pin) {
            controller.onChangeNew(pin);
          },
          enableInteractiveSelection: false,
          cursor: Cursor(
            width: 2,
            color: Colors.grey,
            radius: Radius.circular(1),
            enabled: true,
          ),
        ).paddingSymmetric(horizontal: 10.w),
      ],
    );
  }

  Column buildReset() {
    return Column(
      children: [
        Text('再次输入6位密码', style: TextStyle(fontSize: 18.sp))
            .paddingSymmetric(vertical: 20.h),
        PinInputTextField(
          controller: controller.setTextEditingController,
          pinLength: 6,
          decoration: BoxTightDecoration(
            strokeColor: Colors.grey,
            obscureStyle: ObscureStyle(isTextObscure: true),
          ),
          autoFocus: true,
          textInputAction: TextInputAction.go,
          enabled: true,
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.characters,
          onChanged: (pin) {
            controller.onChangeRe(pin);
          },
          enableInteractiveSelection: false,
          cursor: Cursor(
            width: 2,
            color: Colors.grey,
            radius: Radius.circular(1),
            enabled: true,
          ),
        ).paddingSymmetric(horizontal: 10.w),
        GFButton(
          onPressed: controller.onSet,
          fullWidthButton: true,
          size: GFSize.LARGE,
          color: kAppColor,
          text: '下一步',
          shape: GFButtonShape.pills,
        ).paddingAll(20.w)
      ],
    );
  }
}
