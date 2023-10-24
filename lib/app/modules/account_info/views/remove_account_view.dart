import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/account_info/controllers/account_info_controller.dart';

import '../../../../const/colors.dart';

class RemoveAccountView extends GetView<AccountInfoController> {
  const RemoveAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注销帐号'),
        centerTitle: true,
      ),
      body: GetBuilder<AccountInfoController>(
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HtmlWidget(controller.agreementText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: controller.isRead,
                        activeColor: kAppColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        onChanged: (value) {
                          controller.changeRead(value!);
                        },
                      ),
                      Text(
                        '我已阅读并同意上述内容',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onSubmitRemoveAccount();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 20.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(4.w),
                      ),
                      child: Text(
                        '确认注销',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
