import 'package:badges/badges.dart';
import 'package:bruno/bruno.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '/app/modules/root/controllers/find_controller.dart';
import '../controllers/field_controller.dart';
import '../widget/find_list_view.dart';

class FindView extends GetView<FindController> {
  Widget categoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  PreferredSizeWidget get _buildAppbar {
    return BrnAppBar(
      backgroundColor: kAppColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<FieldController>(
              id: 'update_location',
              builder: (_) {
                return GestureDetector(
                  onTap: controller.onSelectAddress,
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      //Icon(Icons.location_on_rounded),
                      Image.asset(
                        R.ASSETS_ICONS_FIELD_LOCATION_ICON_AT_2X_PNG,
                        width: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      SizedBox(
                        child: Text(
                          _.searchModel.mergename != ''
                              ? _.searchModel.mergename!.split(',').last == ''
                                  ? _.searchModel.mergename!.split(',')[_
                                          .searchModel.mergename!
                                          .split(',')
                                          .length -
                                      2]
                                  : _.searchModel.mergename!.split(',').last
                              : '定位失败',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.FOODIE_ARTICLES),
                child: Image.asset(
                  'assets/images/foodie_icon.png',
                  height: 26.w,
                ),
              ).paddingSymmetric(horizontal: 6.w),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
                child: Badge(
                  position: BadgePosition(top: -6, start: 14.w),
                  showBadge: controller.findData.messageCount != null &&
                      controller.findData.messageCount! > 0,
                  badgeContent: Text(
                    '${controller.findData.messageCount}',
                    style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
                  ),
                  child: Image.asset(
                      R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                      width: 25.w),
                ),
              ).paddingSymmetric(horizontal: 6.w),
              GestureDetector(
                onTap: () =>
                    controller.shareToSession(controller.findData.enjoy!),
                child: Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG,
                    width: 25.w),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
    );
  }

  // 三个广告
  Widget get _buildAD {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
      height: 90.w,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: controller.findData.picture!
            .map(
              (e) => GestureDetector(
                onTap: () {
                  controller.onSelectItem(e);
                },
                child: Container(
                  height: 90.w,
                  width: 110.w,
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(7.w),
                  ),
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(4.w),
                  child: Image.network(e.image!, fit: BoxFit.fitWidth),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // 底部轮播
  Widget get _buildSwiper {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      margin: EdgeInsets.only(top: 8.w, bottom: 0.w, left: 10.w, right: 10.w),
      padding: EdgeInsets.all(10.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(7.w),
      ),
      height: 175.h,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () =>
                controller.onTapItem(controller.findData.advertisement[index]),
            child: Image.network(controller.findData.advertisement[index].image,
                fit: BoxFit.fill),
          );
        },
        itemCount: controller.findData.advertisement.length,
        pagination: new SwiperPagination(
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: _buildAppbar,
        body: controller.obx(
          (state) => EasyRefresh.builder(
            controller: controller.findRefreshController,
            onLoad: controller.onLoadMore,
            onRefresh: controller.onRefresh,
            childBuilder: (context, physics) {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  SliverToBoxAdapter(child: _buildSwiper),
                  SliverToBoxAdapter(child: _buildAD),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    sliver: FindListView(controller.findList),
                  ),
                  // SliverFillRemaining(
                  //   child: FindListView(controller.findList),
                  // ),
                ],
              );
            },
          ),
          // onError: (value) => _buildError(value ?? '系统内部错误'),
          onLoading: BrnPageLoading(),
        ),
        // body: GetBuilder<FindController>(builder: (c) {
        //   return EasyRefresh.builder(
        //     controller: c.findRefreshController,
        //     onLoad: c.onLoadMore,
        //     childBuilder: (context, physics) {
        //       return CustomScrollView(
        //         physics: physics,
        //         slivers: [
        //           SliverToBoxAdapter(child: _buildSwiper),
        //           SliverToBoxAdapter(child: _buildAD),
        //           SliverFillRemaining(
        //             child: FindListView(c.findList),
        //           ),
        //           // FindListView(
        //           //   recordList: controller.recordList,
        //           //   totalPage: controller.totalPage,
        //           // ),
        //         ],
        //       );
        //     },
        //   );
        // }),
      ),
    );
  }
}
