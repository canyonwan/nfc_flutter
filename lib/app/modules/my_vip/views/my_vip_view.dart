import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/vip_model.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/my_vip_controller.dart';

class MyVipView extends GetView<MyVipController> {
  const MyVipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (m) => NestedScrollView(
          headerSliverBuilder: (_, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  title: const Text('购买会员'), pinned: true, centerTitle: true)
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildVipInfo(m!),
                    // 会员权益
                    _buildVipRights(m),
                    // 支付方式
                    _buildPaymentBox()
                  ],
                ),
              ),
              // 底部
              _buildBottomBox(m),
            ],
          ),
        ),
        onLoading: BrnPageLoading(),
        onError: (e) => _buildError(e ?? '系统内部错误'),
      ),
    );
  }

  // 会员权益
  Container _buildVipRights(VipDataModel m) {
    return Container(
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(7.w),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      child: Column(
        children: [
          Text(
            '优源专享卡权益',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ).paddingSymmetric(vertical: 14.w),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.1,
            ),
            itemCount: m.vipExplain!.length,
            itemBuilder: (_, int index) {
              return Column(
                children: [
                  Image.network(m.vipExplain![index].vipImage!,
                      width: 34.w, fit: BoxFit.cover),
                  Text(m.vipExplain![index].vipTitle!,
                      style: TextStyle(fontSize: 14.sp, color: kAppBlackColor)),
                ],
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.w, horizontal: 14.w),
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
            decoration: BoxDecoration(
              color: kAppColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                      text: '全年卡 ',
                      style: TextStyle(fontSize: 18.sp, color: KWhiteColor),
                      children: [
                        TextSpan(
                          text: '${m.cardPrice}',
                          style: TextStyle(fontSize: 26.sp, color: KWhiteColor),
                        ),
                        TextSpan(
                          text: ' 元',
                          style: TextStyle(fontSize: 18.sp, color: KWhiteColor),
                        ),
                      ]),
                ),
                Icon(Icons.check_circle, color: KWhiteColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPaymentBox() {
    return Container(
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(7.w),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('支付方式',
                  style: TextStyle(color: kAppGrey66Color, fontSize: 18.sp))
              .paddingOnly(left: 10.w),
          Divider(),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
            shrinkWrap: true,
            children: controller.ways
                .map((e) => _buildPaymentWay(e.type, e.icon))
                .toList(),
          ),
          Center(
            child:
                Text('暂不支持其他付款方式', style: TextStyle(color: kAppSubGrey99Color)),
          ),
        ],
      ),
    );
  }

  Padding _buildPaymentWay(String type, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(icon, width: 100.w),
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
              value: type == controller.currentWay,
              onChanged: (bool? value) => controller.onSelectWay(type),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildBottomBox(VipDataModel m) {
    return Column(
      children: [
        if (m.isVip == 1)
          Container(
            color: Color(0xffE2EFCD),
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('会员中心',
                    style: TextStyle(fontSize: 11.sp, color: kAppColor)),
                Text('我的会员',
                    style: TextStyle(fontSize: 11.sp, color: kAppColor)),
              ],
            ),
          ),
        GestureDetector(
          onTap: controller.onPay,
          child: Container(
            color: KWhiteColor,
            padding: EdgeInsets.only(bottom: 20.w, top: 4.w),
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kAppColor,
                borderRadius: BorderRadius.circular(40.w),
              ),
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
              child: Text(m.isVip == 1 ? '立即续费' : '立即支付',
                  style: TextStyle(fontSize: 18.sp, color: KWhiteColor)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVipInfo(VipDataModel m) {
    return Container(
      color: KWhiteColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Row(
        children: [
          Image.network(
            m.memberImg!,
            width: 60.w,
            height: 60.w,
            fit: BoxFit.cover,
          ).paddingOnly(right: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${m.memberName}',
                    style: TextStyle(fontSize: 16.sp),
                  ).paddingOnly(right: 4.w),
                  Image.asset(R.ASSETS_ICONS_MINE_NO_VIP_PNG,
                      width: 20.w,
                      fit: BoxFit.cover,
                      color: m.isVip == 1 ? kAppColor : null),
                ],
              ).paddingOnly(bottom: 10.w),
              if (m.isVip == 0)
                Text(
                  '当前未开通会员',
                  style: TextStyle(fontSize: 11.sp, color: kAppSubGrey99Color),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '已开通会员',
                      style: TextStyle(fontSize: 11.sp, color: kAppGrey66Color),
                    ),
                    Text(
                      '${m.endTime}',
                      style: TextStyle(fontSize: 11.sp, color: kAppGrey66Color),
                    )
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return BrnAbnormalStateWidget(
      isCenterVertical: true,
      title: '$error',
      operateAreaType: OperateAreaType.singleButton,
      operateTexts: ["点击重试"],
      action: (int index) {
        if (index == 0) {
          controller.getShowVip();
        }
      },
    );
  }
}
