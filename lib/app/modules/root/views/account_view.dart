import 'package:badges/badges.dart';
import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/controllers/account_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class AccountView extends GetView<AccountController> {
  Widget _buyMembership() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      padding: EdgeInsets.symmetric(vertical: 21.5.w, horizontal: 17.5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(R.ASSETS_ICONS_MINE_PRESELL_BG_PNG),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "buy_member".tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFEF4E4),
                ),
              ).paddingOnly(bottom: 6.w),
              Text(
                controller.info.isVip == 1
                    ? '${controller.info.save}'
                    : '开通会员享权益',
                style: TextStyle(
                  color: Color(0xff8F5500),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: controller.openVip,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: kBgGreyColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.w),
              child: Text(
                controller.info.isVip == 1 ? '立即查看' : '立即开通',
                style: TextStyle(fontSize: 13.sp, color: Color(0xff8F5500)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _order() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KWhiteColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('我的订单', style: TextStyle(fontSize: 18.sp)),
              GestureDetector(
                onTap: () =>
                    Get.toNamed(Routes.MY_ORDER, arguments: {'type': 1}),
                child: Row(
                  children: [
                    Text('全部订单',
                        style: TextStyle(
                            fontSize: 12.sp, color: kAppSubGrey99Color)),
                    Icon(Icons.keyboard_arrow_right_outlined,
                        color: kAppSubGrey99Color),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 19.w, bottom: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                orderItem(R.ASSETS_ICONS_MINE_DAIFUKUAN_ICON_PNG, '待付款',
                    controller.info.memberStaypayCount ?? 0, () {
                  Get.toNamed(Routes.MY_ORDER, arguments: {'type': 2});
                }),
                orderItem(R.ASSETS_ICONS_MINE_DAIFAHUO_ICON_PNG, '待发货',
                    controller.info.memberAlreadycollectCount ?? 0, () {
                  Get.toNamed(Routes.MY_ORDER, arguments: {'type': 3});
                }),
                orderItem(R.ASSETS_ICONS_MINE_DAISHOUHUO_ICON_PNG, '待收货',
                    controller.info.memberStaycollectCount ?? 0, () {
                  Get.toNamed(Routes.MY_ORDER, arguments: {'type': 4});
                }),
                orderItem(R.ASSETS_ICONS_MINE_DAIPINGJIA_ICON_PNG, '待评价',
                    controller.info.memberEvaluateCount ?? 0, () {
                  Get.toNamed(Routes.MY_ORDER, arguments: {'type': 5});
                }),
                orderItem(R.ASSETS_ICONS_MINE_SHOUHOU_TUIKUAN_ICON_PNG, '售后/退款',
                    controller.info.memberRefundCount ?? 0, () {
                  Get.toNamed(Routes.MY_REFUND_ORDER);
                }),
              ],
            ),
          ),
          if (controller.info.ifLogistics == 1)
            Container(
              decoration: BoxDecoration(
                color: kBgGreyColor,
                borderRadius: BorderRadius.circular(7.w),
              ),
              child: Row(
                children: [
                  Image.network('${controller.info.logisticsInfo!.picture}',
                          width: 100.w, fit: BoxFit.cover)
                      .paddingOnly(right: 7.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${controller.info.logisticsInfo!.title}',
                                style: TextStyle(fontSize: 12.sp)),
                            Text(
                              '${controller.info.logisticsInfo!.time}',
                              style: TextStyle(
                                  fontSize: 12.sp, color: kAppSubGrey99Color),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        Text('${controller.info.logisticsInfo!.content}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: kAppSubGrey99Color,
                            )),
                      ],
                    ).paddingSymmetric(vertical: 8.5.w),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget orderItem(String icon, String name, int count, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        showBadge: count > 0,
        badgeContent: Text(
          '${count}',
          style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
        ),
        child: Column(
          children: [
            Image.asset(icon, width: 34.w, height: 34.w),
            Text(
              '${name}',
              style: TextStyle(color: kAppGrey66Color, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  // 我的资产
  Widget get _myAssets {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.5.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('我的资产', style: TextStyle(fontSize: 18.sp))
              .paddingOnly(bottom: 20.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MY_GIFT_CARD, arguments: {'type': 1});
                },
                child: Image.asset(
                  R.ASSETS_ICONS_MINE_DAIJINQUAN_ICON_PNG,
                  width: 40.h,
                  height: 40.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // 积分
                  Get.toNamed(Routes.MY_INTEGRAL);
                },
                child: Image.asset(
                  R.ASSETS_ICONS_MINE_JIFEN_ICON_PNG,
                  width: 40.h,
                  height: 40.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MY_BALANCE);
                },
                child: Image.asset(
                  R.ASSETS_ICONS_MINE_YUE_ICON_PNG,
                  width: 40.h,
                  height: 40.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MY_GIFT_CARD, arguments: {'type': 0});
                },
                child: Image.asset(
                  R.ASSETS_ICONS_MINE_LIPINKA_ICON_PNG,
                  width: 40.h,
                  height: 40.h,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MY_GIFT_CARD, arguments: {'type': 2});
                },
                child: Image.asset(
                  R.ASSETS_ICONS_MINE_CHONGZHIKA_ICON_PNG,
                  width: 40.h,
                  height: 40.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 我的服务
  Widget get _myServers {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: KWhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('我的服务', style: TextStyle(fontSize: 18.sp))
                .paddingOnly(bottom: 20.w),
            Row(
              children: [
                GestureDetector(
                  // onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
                  onTap: controller.onLaunchInBrowser,
                  child: Image.asset(
                    R.ASSETS_ICONS_MINE_HELP_AND_KEFU_PNG,
                    width: 44.h,
                    height: 44.h,
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.HEALTH_BUTLER),
                  child: Image.asset(
                    R.ASSETS_ICONS_MINE_JIANKANGGUANJIA_ICON_PNG,
                    width: 40.h,
                    height: 40.h,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      body: controller.obx(
        (state) => EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: controller.onRefresh,
          childBuilder: (_, physics) {
            return CustomScrollView(
              physics: physics,
              slivers: [
                _buildSliverAppbar,
                buildEasyRefresh(),
              ],
            );
          },
        ),
        onError: (value) => _buildError(value ?? '系统内部错误'),
        // onLoading: BrnPageLoading(),
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
          controller.getAccountInfo();
        }
      },
    );
  }

  Widget get _buildSliverAppbar {
    return ExtendedSliverAppbar(
      leading: SizedBox(),
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xffDCEBC2), Color(0xffffffff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GetBuilder<AccountController>(builder: (c) {
          return Container(
            padding: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            child: Column(
              children: [
                // 用户头像
                Row(
                  children: [
                    CircleAvatar(
                            radius: 30.w,
                            backgroundImage: NetworkImage(c.info.memberImg!))
                        .paddingOnly(right: 10.w),
                    GestureDetector(
                      onTap: controller.onEditNickname,
                      child: Text(
                        '${c.info.memberName}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20.w),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildColText('喜欢', '${c.info.goodsLike}', Routes.MY_LIKES),
                    buildColText(
                        '足迹', '${c.info.browseCount}', Routes.MY_FOOTPRINT),
                    buildColText(
                        '猜你喜欢', '${c.info.guessLike}', Routes.GUESS_LIKE),
                    buildColText(
                        '不喜欢', '${c.info.goodsNotLike}', Routes.MY_DISLIKES),
                  ],
                ).paddingSymmetric(vertical: 30.w, horizontal: 30.w),
              ],
            ),
          );
        }),
      ),
      actions: Row(
        children: [
           GestureDetector(
             onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
             child: Badge(
               showBadge: controller.info.ifMessageShow == 0 &&
                   controller.info.messageCount! > 0,
              badgeContent: Text(
                '${controller.info.messageCount}',
                 style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
               ),
               child: Image.asset(R.ASSETS_ICONS_MINE_MINE_MESSAGE_ICON_PNG,
                  width: 20.w),
             ),
           ),
          GestureDetector(
            onTap: controller.onViewQRCode,
            child: Image.asset(R.ASSETS_ICONS_MINE_QRCODE_ICON_PNG, width: 20.w)
                .paddingSymmetric(horizontal: 16.w),
          ),
          GestureDetector(
            // onTap: () => Get.toNamed(Routes.SETTING),
            onTap: controller.toSettings,
            child:
                Image.asset(R.ASSETS_ICONS_MINE_SETTING_ICON_PNG, width: 20.w)
                    .paddingOnly(right: 8.w),
          ),
        ],
      ),
    );
  }

  Widget buildColText(String name, String num, String page) {
    return GestureDetector(
      onTap: () => Get.toNamed(page),
      child: Column(
        children: [
          Text('$num',
              style: TextStyle(color: kAppBlackColor, fontSize: 22.sp)),
          Text('$name',
              style: TextStyle(fontSize: 13.sp, color: kAppBlackColor)),
        ],
      ),
    );
  }

  Widget buildEasyRefresh() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buyMembership(),
          _order(),
          _myAssets,
          _myServers,
        ],
      ),
    );
  }

  Widget get buildAppBar {
    return AppBar(
      title: Text("account".tr),
      centerTitle: true,
      elevation: 0,
      actions: [
        GestureDetector(
          onTap: () async {
            var data = await Get.toNamed(Routes.SETTING);
            if (data != null) {
              if (data == "out") {
                controller.setMember();
              }
            }
          },
          child: const Icon(
            Icons.settings,
             size: 30,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.MESSAGE_CENTER);
          },
          child: Badge(
            child: const Icon(
              Icons.notifications_none,
              size: 30,
            ),
            badgeContent: Text('100'),
          ),
        ),
      ],
    );
  }
}
