import 'package:badges/badges.dart';
import 'package:better_video_player/better_video_player.dart';
import 'package:bruno/bruno.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/field_detail/views/claim_and_buy_view.dart';
import 'package:mallxx_app/app/modules/field_detail/views/decision_and_manage_view.dart';
import 'package:mallxx_app/app/modules/field_detail/views/field_content_view.dart';
import 'package:mallxx_app/app/modules/field_detail/views/live_action_records_view.dart';
import 'package:mallxx_app/app/modules/field_detail/views/vr_upload_view.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/field_detail_controller.dart';

class FieldDetailView extends GetView<FieldDetailController> {
  const FieldDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: controller.obx(
        (state) => _buildNestedView,
        onLoading: Center(child: BrnPageLoading()),
        onEmpty: Center(child: Text('空空如也!')),
      ),
    );
  }

  Widget get _buildNestedView {
    return Stack(
      children: [
        ExtendedNestedScrollView(
          controller: controller.scrollController,
          pinnedHeaderSliverHeightBuilder: () =>
              Get.mediaQuery.padding.top + kToolbarHeight,
          headerSliverBuilder: (_, bool innerBoxIsScrolled) {
            return [_buildSliverAppbar, _buildTopBox];
          },
          body: Column(
              children: [_buildTabsBox, _buildTabBarView, _buildBottomButton]),
        ),
        _buildFloatingButtonGroup,
      ],
    );
  }

  Widget get _buildSliverAppbar {
    return SliverAppBar(
      leading: new IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 20.w,
        onPressed: () {
          Get.back();
        },
      ),
      pinned: true,
      centerTitle: false,
      backgroundColor: kAppColor,
      title: GetBuilder<FieldDetailController>(
          id: 'updateFieldDetail',
          builder: (c) {
            return Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: SizedBox(
                      child: Text(
                        c.dataModel.title ?? '加载中..',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
          child: Badge(
            position: BadgePosition(top: 2.h, start: 14.w),
            showBadge: controller.dataModel.ifMessageShow == 0 &&
                controller.dataModel.messageCount != 0,
            badgeContent: Text(
              '${controller.dataModel.messageCount}',
              style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
            ),
            child: Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                width: 26.w),
          ),
        ),
        GetBuilder<FieldDetailController>(
            id: 'updateFieldDetail',
            builder: (c) {
              return GestureDetector(
                onTap: () => c.onCollectField(c.dataModel),
                child: Image.asset(
                  c.dataModel.ifLike == 0
                      ? 'assets/icons/field/un_shoucang.png'
                      : 'assets/icons/field/shoucang.png',
                  width: 26.w,
                ).paddingSymmetric(horizontal: 4.w),
              );
            }),
        Padding(
          padding: EdgeInsets.only(right: 12.5.w),
          child: GestureDetector(
            onTap: () => controller.shareToSession(controller.dataModel),
            child:
                Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG, width: 26.w),
          ),
        ),
      ],
    );
  }

  Widget get _buildFloatingButtonGroup {
    return GetBuilder<FieldDetailController>(
        id: 'update_goods_count',
        builder: (c) {
          return Positioned(
            bottom: 180.h,
            right: 14.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.SHOP_CART);
                  },
                  child: Badge(
                    position: BadgePosition(top: -6.w, end: -1.w),
                    showBadge: c.goodsCount != 0,
                    badgeContent: Text('${c.goodsCount}',
                        style: TextStyle(color: KWhiteColor)),
                    child: Image.asset(R.ASSETS_ICONS_FIELD_CART_CIRCLE_PNG,
                        width: 40.w),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.MY_ORDER, arguments: {'type': 1}),
                  child: Badge(
                    position: BadgePosition(top: -6.w, end: -1.w),
                    showBadge: c.orderCount != 0,
                    badgeContent: Text('${c.orderCount}',
                        style: TextStyle(color: KWhiteColor)),
                    child: Image.asset(R.ASSETS_ICONS_FIELD_ORDER_PNG,
                        width: 40.w),
                  ),
                ),
                GestureDetector(
                  onTap: () => c.scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear),
                  child: Image.asset(R.ASSETS_ICONS_FIELD_BACKTOP_PNG,
                      width: 40.w),
                ),
              ],
            ),
          );
        });
  }

  Widget get _buildBottomButton {
    return GestureDetector(
      onTap: () => controller.onComplaint(),
      child: Container(
        padding: EdgeInsets.only(top: 10.h),
        height: 50.h,
        width: Get.width,
        color: Color(0xffEBEBEB),
        child: Text(
          '我要投诉',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      ),
    );
  }

  GetBuilder get _buildTabBarView {
    return GetBuilder<FieldDetailController>(
      builder: (c) {
        return Expanded(
          child: TabBarView(
            controller: c.tabController,
            children: [
              if (c.dataModel.ifRecord == 1)
                LiveActionRecordsView(
                  recordList: c.recordList,
                  totalPage: c.totalPage,
                ), // 实景记录
              if (c.dataModel.ifDecision == 1)
                GetBuilder<FieldDetailController>(
                    id: 'uploadImage',
                    builder: (ctx) {
                      return DecisionAndManageView(ctx.dataModel.decisionList!);
                    }), // 决策管理
              if (c.dataModel.ifContent == 1)
                GetBuilder<FieldDetailController>(
                    id: 'updateFieldDetail',
                    builder: (context) {
                      return FieldContentView(c.dataModel);
                    }), // 详情资料
              if (c.dataModel.ifProduct == 1)
                ClaimAndBuyView(
                  c.dataModel.goodsList!,
                  c.dataModel.claimList!,
                  c.dataModel.chippedList!,
                ), // 认领购买
            ],
          ),
        );
      },
    );
  }

  // 没有视频显示天气
  Widget get _buildTopBox {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          GetBuilder<FieldDetailController>(
              id: 'updateFieldDetail',
              builder: (c) {
                return c.dataModel.videoFile != null &&
                        c.dataModel.videoFile != ''
                    ? _buildVideoPlayer
                    : _buildWeather;
              }),
          Positioned(
            right: 10.w,
            top: 20.h,
            child: _buildMediaButtons(),
          )
        ],
      ),
    );
  }

  Widget get _buildTabsBox {
    return GetBuilder<FieldDetailController>(
        id: 'updateFieldDetail',
        builder: (c) {
          return TabBar(
            isScrollable: true,
            controller: c.tabController,
            indicatorColor: kAppColor,
            labelStyle: TextStyle(
              color: kAppColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: kAppSubGrey99Color,
              fontSize: 14.sp,
            ),
            tabs: [
              if (c.dataModel.ifRecord == 1)
                Tab(
                  child: Row(
                    children: [
                      Text('实景记录'),
                      GestureDetector(
                        onTap: () => c.onSortRecord(c.sort),
                        child: Image.asset(
                          c.sort == 1
                              ? R.ASSETS_ICONS_MARKET_SORT_DOWN_PNG
                              : R.ASSETS_ICONS_MARKET_SORT_UP_PNG,
                          width: 9.w,
                        ).paddingOnly(left: 5.w),
                      ),
                    ],
                  ),
                ),
              if (c.dataModel.ifDecision == 1) Tab(text: '决策管理'),
              if (c.dataModel.ifContent == 1) Tab(text: '详情资料'),
              if (c.dataModel.ifProduct == 1) Tab(text: '认领购买'),
            ],
          );
        });
  }

  Widget get _buildVideoPlayer {
    return GetBuilder<FieldDetailController>(
        id: 'updateFieldDetail',
        builder: (c) {
          return Container(
            child: AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: BetterVideoPlayer(
                controller: c.videoController,
                configuration: BetterVideoPlayerConfiguration(
                  autoPlay: false,
                  placeholder: Image.network(
                    c.dataModel.videoImage!,
                    fit: BoxFit.contain,
                  ),
                  // controls: _CustomControls(isFullScreen: false),
                  // fullScreenControls: _CustomControls(isFullScreen: true),
                ),
                dataSource: BetterVideoPlayerDataSource(
                  BetterVideoPlayerDataSourceType.network,
                  c.dataModel.videoFile!,
                ),
              ),
            ),
          );
        });
  }

  Widget get _buildWeather {
    return GetBuilder<FieldDetailController>(
        id: 'updateFieldDetail',
        builder: (c) {
          return Container(
            height: 250.h,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(c.dataModel.weather!.backImage!),
                    fit: BoxFit.fill,
                  ),
                )),
                Container(
                  width: Get.width,
                  // height: ,
                  color: kAppBlackColor.withOpacity(.5),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 30.5.w, right: 60.w, bottom: 20.h),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.5.h, bottom: 20.5.h),
                        child: Row(
                          children: [
                            Image.network(c.dataModel.weather!.iconImg!,
                                width: 48.w),
                            Column(
                              children: [
                                Text(
                                  ' ${c.dataModel.weather!.temp}℃',
                                  style: TextStyle(
                                      fontSize: 36.sp,
                                      color: KWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ${c.dataModel.weather!.text}',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: KWhiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      //  天气信息
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          colText('${c.dataModel.weather!.feelsLike}℃', '体感温度'),
                          colText(
                              '${c.dataModel.weather!.windSpeed}km/h', '风速'),
                          colText('${c.dataModel.weather!.windDir}', '风向'),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            colText('${c.dataModel.weather!.humidity}%', '湿度'),
                            colText('${c.dataModel.weather!.precip}mm', '降水量'),
                            colText(
                                '${c.dataModel.weather!.windScale}级', '风力等级'),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          colText(
                              '${c.dataModel.weather!.pressure}hPa', '大气压强'),
                          colText('${c.dataModel.weather!.vis}km', '能见度'),
                          colText('${c.dataModel.weather!.air}', '空气质量'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildMediaButtons() {
    return GetBuilder<FieldDetailController>(builder: (c) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (c.buttonStatusDataModel.status == 2)
            GestureDetector(
                onTap: () => Get.toNamed(Routes.MY_WEBVIEW, arguments: {
                      'first': c.buttonStatusDataModel.liveAddress!,
                      'second': c.fieldId.toString(),
                      'type': 1
                    }),
                child: Image.asset(R.ASSETS_ICONS_FIELD_ZHUCHIZHIBO_PNG,
                    width: 50.w)),
          if (c.buttonStatusDataModel.ifMonitor2 == 2)
            GestureDetector(
              onTap: () => Get.toNamed(
                Routes.REAL_TIME_LIST,
                arguments: {
                  'list': c.buttonStatusDataModel.monitorAddress2,
                  'token': c.buttonStatusDataModel.monitorToken,
                },
              ),
              child: Image.asset(R.ASSETS_ICONS_FIELD_SHISHIHUAMIAN_PNG,
                      width: 50.w)
                  .paddingSymmetric(vertical: 10.h),
            ),
          if (c.buttonStatusDataModel.ifVr == 2)
            GestureDetector(
                onTap: () => Get.toNamed(
                      Routes.VR360,
                      arguments: {'list': c.buttonStatusDataModel.vrList},
                    ),
                child: Image.asset(R.ASSETS_ICONS_FIELD_VR_PNG, width: 50.w)),
          // Image.asset(R.ASSETS_ICONS_FIELD_YUANCHENGJIANKONG_PNG, width: 50.w),
          if (c.buttonStatusDataModel.ifUpload == 2)
            GestureDetector(
              onTap: () {
                Get.to(() => VrUploadView(),
                    arguments: {'articleId': c.fieldId});
              },
              child: Image.asset('assets/images/image_upload_icon.png',
                      width: 50.w)
                  .paddingOnly(top: 10.h),
            )
        ],
      );
    });
  }

  Widget colText(String value, String text) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
              fontSize: 15.sp, color: KWhiteColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h),
        Text(text, style: TextStyle(fontSize: 10.sp, color: Color(0xffE9E9E9))),
      ],
    );
  }
}
