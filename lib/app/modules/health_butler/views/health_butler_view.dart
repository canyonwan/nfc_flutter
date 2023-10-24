import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/health_butler_controller.dart';

class HealthButlerView extends GetView<HealthButlerController> {
  const HealthButlerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('餐饮管家'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BrnInputText(
              textEditingController: controller.textEditingController,
              maxHeight: 500,
              minHeight: 100,
              minLines: 1,
              maxLength: 500,
              bgColor: KWhiteColor,
              textString: '',
              textInputAction: TextInputAction.newline,
              maxHintLines: 500,
              hint: '记录下你的餐饮禁忌, 及口味偏好, 农副仓将为您提供更优质的推荐!',
              padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
              onTextChange: (text) {
                controller.content = text;
              },
              onSubmit: (text) {
                controller.content = text;
              },
            ),
          ),
          GestureDetector(
            onTap: controller.onSubmit,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.w),
              decoration: BoxDecoration(
                color: kAppColor,
                borderRadius: BorderRadius.circular(40.w),
              ),
              child: Text('提交',
                  style: TextStyle(fontSize: 16.sp, color: KWhiteColor)),
            ),
          ),
        ],
      ),
    );
  }
}
