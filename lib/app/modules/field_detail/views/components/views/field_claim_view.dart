import 'package:bruno/bruno.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/components/number_item.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/modules/field_detail/controllers/field_detail_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/const/colors.dart';

class FieldClaimView extends GetView<FieldDetailController> {
  const FieldClaimView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClaimFieldDataModel model = Get.arguments;

    BoxDecoration _border = BoxDecoration(
      border: Border.all(width: 1, color: kBgGreyColor),
    );
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('农场认领'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              children: [
                Container(
                  decoration: _border,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 26.w, vertical: 5.w),
                        margin: EdgeInsets.only(bottom: 10.h),
                        color: kAppLightColor,
                        child: Text('${model.reapTime}',
                            style:
                                TextStyle(color: kAppColor, fontSize: 14.sp)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.6.w, left: 11.5.w),
                        child: Text(
                          '${model.name}',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 11.5.w, bottom: 23.h),
                        child: Text(
                          '${model.describe}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff666666),
                            height: 1.3.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 11.5.w, bottom: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: model.price,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' / ${model.units}',
                                    style: TextStyle(
                                        color: kAppSubGrey99Color,
                                        fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<FieldDetailController>(builder: (c) {
                              return NumberItem(
                                number: c.count.value,
                                isEnable: true,
                                addClick: (value) => c.onIncrement(value),
                                subClick: (value) => c.onIncrement(value),
                              );
                            })
                          ],
                        ),
                      ),
                      ExpandChild(
                        indicatorBuilder: (context, onTap, expanded) => InkWell(
                          onTap: onTap,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '查看全文',
                                style: TextStyle(
                                    color: kAppColor, fontSize: 14.sp),
                              ),
                              Icon(
                                expanded
                                    ? Icons.keyboard_arrow_up_outlined
                                    : Icons.keyboard_arrow_down_outlined,
                                color: kAppColor,
                              )
                            ],
                          ),
                        ),
                        child: HtmlWidget(model.content!),
                      ),
                      SizedBox(height: 10.w),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: _border,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 26.w, vertical: 5.w),
                        margin: EdgeInsets.only(bottom: 10.h),
                        color: kAppLightColor,
                        child: Text('默认联系人信息',
                            style:
                                TextStyle(color: kAppColor, fontSize: 14.sp)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.6.w, left: 11.5.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '姓名：',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: TextField(
                                    // controller: controller.nameController,
                                    decoration: InputDecoration(
                                      hintText: '请输入姓名',
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kAppSubGrey99Color),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      controller.claimName = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '电话：',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: TextField(
                                    // controller: controller.nameController,
                                    decoration: InputDecoration(
                                      hintText: '请输入电话',
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kAppSubGrey99Color),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      controller.claimPhone = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '所在地区：',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: GetBuilder<FieldController>(
                                    id: 'update_location',
                                    builder: (_) {
                                      return GestureDetector(
                                        onTap: () => _.onSelectAddress(false),
                                        child: SizedBox(
                                          child: Text(
                                            _.searchModel.mergename!.isNotEmpty
                                                ? _.searchModel.mergename!
                                                : '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '详细地址：',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: TextField(
                                    // controller: controller.nameController,
                                    decoration: InputDecoration(
                                      hintText: '街道/小区',
                                      hintStyle: TextStyle(
                                          fontSize: 13.sp,
                                          color: kAppSubGrey99Color),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      controller.claimAddress = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: 14.h, horizontal: Get.width / 4),
              color: kAppLightColor,
              child: GetBuilder<FieldDetailController>(builder: (c) {
                return BrnCheckbox(
                  radioIndex: 20,
                  isSelected: c.isAgree,
                  mainAxisSize: MainAxisSize.max,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: kAppColor,
                        fontWeight: FontWeight.bold),
                    child: GetBuilder<FieldDetailController>(builder: (c) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('已阅读并同意',
                              style: TextStyle(color: kAppBlackColor)),
                          GestureDetector(
                            onTap: c.getClaimAgreement,
                            child: Text('《认领协议》'),
                          ),
                        ],
                      );
                    }),
                  ),
                  onValueChangedAtIndex: (index, value) {
                    c.isAgree = value;
                  },
                );
              })),
          GetBuilder<FieldDetailController>(
              id: 'calcPrice',
              builder: (c) {
                return Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '总计：',
                          style: TextStyle(
                            color: kAppBlackColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '￥',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 13.sp),
                            ),
                            TextSpan(
                              text: '${c.claimFieldData.totalPrice}',
                              // text: '${int.parse(model.price!) * 1}',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: c.onSubmitPay,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 64.w),
                          decoration: BoxDecoration(
                            color: kAppColor,
                            borderRadius: BorderRadius.circular(40.w),
                          ),
                          child: Text(
                            '确认支付',
                            style:
                                TextStyle(color: KWhiteColor, fontSize: 14.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
