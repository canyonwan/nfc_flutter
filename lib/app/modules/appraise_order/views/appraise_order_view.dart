import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/appraise_order_controller.dart';

class AppraiseOrderView extends GetView<AppraiseOrderController> {
  const AppraiseOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('发表评价'), centerTitle: true),
      body: ListView(
        children: [
          Row(
            children: [
              Image.network(controller.goodsImage,
                  width: 100.w, fit: BoxFit.cover),
              Text(
                '评分',
                style: TextStyle(fontSize: 14.sp, color: kAppSubGrey99Color),
              ).paddingSymmetric(horizontal: 10.w),
              GetBuilder<AppraiseOrderController>(builder: (c) {
                return GFRating(
                  borderColor: Colors.orange,
                  color: Colors.orange,
                  value: c.rateValue,
                  onChanged: (value) => controller.onRatingChanged(value),
                );
              }),
            ],
          ).paddingAll(14.w),
          Divider(),
          BrnInputText(
            autoFocus: false,
            maxHeight: 300,
            minHeight: 100,
            minLines: 3,
            maxLength: 500,
            hint: '宝贝满足你的期待吗? 说说你的使用心得, 分享给想买的他们吧!',
            padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
            onTextChange: (text) {
              controller.contents = text;
            },
          ),
          GetBuilder<AppraiseOrderController>(builder: (controller) {
            return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10.5.w,
                  crossAxisSpacing: 6.w,
                ),
                itemCount: controller.imageUrls.length + 1,
                itemBuilder: (_, int index) {
                  if (index == controller.imageUrls.length) {
                    return GestureDetector(
                      onTap: controller.onUploadImage,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: kAppSubGrey99Color),
                          borderRadius: BorderRadius.circular(7.w),
                        ),
                        width: 100.w,
                        height: 100.w,
                        child: Icon(Icons.add, color: kAppSubGrey99Color),
                      ),
                    );
                  }
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: kAppSubGrey99Color),
                      borderRadius: BorderRadius.circular(7.w),
                    ),
                    width: 100.w,
                    height: 100.w,
                    child: Image.network(
                      controller.imageUrls[index],
                      fit: BoxFit.fill,
                      width: 100.w,
                      height: 100.w,
                    ),
                  );
                });
          }),
          Row(
            children: [
              // GetBuilder<AppraiseOrderController>(builder: (c) {
              //   return GFCheckbox(
              //     customBgColor: kAppColor,
              //     size: GFSize.SMALL,
              //     activeBgColor: GFColors.SUCCESS,
              //     onChanged: (value) => c.onRadioChanged(value),
              //     value: c.isAnonymous,
              //   );
              // }),
              // Text('匿名发布', style: TextStyle())
            ],
          ),
          Divider(),
          SizedBox(
            height: 40.w,
            child: GFButton(
              color: kAppColor,
              size: GFSize.LARGE,
              onPressed: controller.onAppraise,
              text: '提  交',
              fullWidthButton: true,
              textStyle: TextStyle(fontSize: 14.sp),
            ).marginSymmetric(horizontal: 20.w),
          ),
        ],
      ),
    );
  }
}
