import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../const/colors.dart';
import '../controllers/change_gender_controller.dart';

class ChangeGenderView extends GetView<ChangeGenderController> {
  const ChangeGenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('修改性别'), centerTitle: true),
      body: ListView(
        shrinkWrap: true,
        children: controller.ways
            .map((e) => _buildPaymentWay(e.type, e.name))
            .toList(),
      ),
    );
  }

  Container _buildPaymentWay(int type, String name) {
    return Container(
      color: KWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$name',
              style: TextStyle(fontSize: 14.sp, color: kAppBlackColor)),
          GetBuilder<ChangeGenderController>(builder: (c) {
            return SizedBox(
              width: 30.w,
              height: 30.w,
              child: Checkbox(
                tristate: true,
                shape: const CircleBorder(),
                activeColor: kAppColor,
                checkColor: KWhiteColor,
                hoverColor: KWhiteColor,
                focusColor: kAppColor,
                side: const BorderSide(color: Colors.grey, width: 1),
                value: type == c.current,
                onChanged: (bool? value) => c.onSelectWay(type),
              ),
            );
          }),
        ],
      ),
    );
  }
}
