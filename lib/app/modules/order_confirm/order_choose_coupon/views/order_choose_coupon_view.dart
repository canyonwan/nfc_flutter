import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/choose_coupon_list_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/order_choose_coupon_controller.dart';

class OrderChooseCouponView extends GetView<OrderChooseCouponController> {
  final String? totalPrice;

  const OrderChooseCouponView({Key? key, this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderChooseCouponController>(
        init: OrderChooseCouponController(totalPrice: totalPrice),
        builder: (c) {
          return Container(
            padding: EdgeInsets.only(top: 10.w),
            height: Get.height / 2,
            decoration: BoxDecoration(
              color: KWhiteColor,
            ),
            child: Column(
              children: [
                BrnSwitchTitle(
                  nameList: [
                    '可用代金券(${c.data.canUseCount})',
                    '不可用代金券(${c.data.notUseCount})'
                  ],
                  defaultSelectIndex: c.currentTab,
                  onSelect: (value) => c.onChangeTab(value),
                  padding: EdgeInsets.fromLTRB(25.w, 6.h, 50.w, 14.w),
                ),
                Expanded(
                  child: c.data.canUse != null
                      ? _buildBox(
                          c.currentTab == 0 ? c.data.canUse! : c.data.notUse!)
                      : Text('加载中..'),
                ),
                if (c.currentTab == 0)
                  GestureDetector(
                    onTap: c.onSubmit,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                      width: Get.width,
                      color: kAppColor,
                      alignment: Alignment.center,
                      child: Text(
                        '确认',
                        style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBox(List<ChooseCouponModel> model) {
    return ListView(
      padding: EdgeInsets.all(10.w),
      children: model.map((e) => _buildItem(e)).toList(),
    );
  }

  Widget _buildItem(ChooseCouponModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: kBgGreyColor,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        children: [
          DefaultTextStyle(
            style: TextStyle(
                color: controller.currentTab == 0
                    ? kAppColor
                    : kAppSubGrey99Color),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: '￥',
                    style: TextStyle(fontSize: 12.sp),
                    children: [
                      TextSpan(
                          text: '${model.price}',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  '满${model.full}可用',
                  style: TextStyle(fontSize: 12.sp),
                )
              ],
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: controller.currentTab == 0
                          ? kAppBlackColor
                          : kAppSubGrey99Color),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.w),
                  child: Text(model.explain!,
                      style:
                          TextStyle(color: kAppGrey66Color, fontSize: 10.sp)),
                ),
                Text('${model.startTime}-${model.endTime}',
                    style: TextStyle(
                        color: controller.currentTab == 0
                            ? kAppBlackColor
                            : kAppSubGrey99Color)),
              ],
            ),
          ),
          if (controller.currentTab == 0)
            SizedBox(
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
                value: controller.selectedId == model.id!,
                onChanged: (bool? value) => controller.onSelect(model.id!),
              ),
            ),
        ],
      ),
    );
  }
}
