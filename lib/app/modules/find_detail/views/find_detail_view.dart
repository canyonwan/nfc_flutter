import 'package:better_video_player/better_video_player.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/find_detail_controller.dart';

class FindDetailView extends GetView<FindDetailController> {
  const FindDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: GetBuilder<FindDetailController>(
        builder: (c) {
          if (c.type == 1) {
            if (c.videoDetailData == null) {
              return Center(child: BrnPageLoading());
            } else {
              return buildNestedScrollView();
            }
          } else {
            if (c.dynamicDetailData == null) {
              return Center(child: BrnPageLoading());
            } else {
              return buildNestedScrollView();
            }
          }
        },
      ),
    );
  }

  Widget ImageItem(url) {
    return GestureDetector(
      onTap: () => controller.onZoomImage(url),
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.5.w),
            topRight: Radius.circular(7.5.w),
          ),
        ),
        child: Image(
          image: NetworkImage(url),
          height: 200.w,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
              centerTitle: true,
              title: Text(controller.type == 1
                  ? controller.videoDetailData!.title!
                  : controller.dynamicDetailData!.title!),
              pinned: true,
              actions: [
                GestureDetector(
                  onTap: () => controller.onShare(controller.type == 1
                      ? controller.videoDetailData!.enjoy!
                      : controller.dynamicDetailData!.enjoy!),
                  child: Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG,
                      width: 25.w),
                ),
                SizedBox(width: 10.w),
              ]),
        ];
      },
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 标题和日期
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.w),
                Text(
                  controller.type == 1
                      ? controller.videoDetailData!.title!
                      : controller.dynamicDetailData!.title!,
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 10.w),
                Text(
                  '日期：${controller.type == 1 ? controller.videoDetailData!.createtime : controller.dynamicDetailData!.createtime}',
                  style: TextStyle(fontSize: 12.sp, color: kAppGrey66Color),
                ),
                SizedBox(height: 20.w),
              ],
            ),
          ),
          if (controller.type == 2)
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
              child: Text(
                controller.dynamicDetailData!.content!,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          if (controller.type == 2)
            GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 10.w,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: controller.dynamicDetailData!.images!
                  .map((e) => ImageItem(e))
                  .toList(),
            ),
          if (controller.type == 1)
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: BetterVideoPlayer(
                controller: controller.videoController,
                dataSource: BetterVideoPlayerDataSource(
                  BetterVideoPlayerDataSourceType.network,
                  controller.videoDetailData!.videoReturn!,
                ),
                configuration: BetterVideoPlayerConfiguration(
                  placeholder: Image.network(
                    controller.videoDetailData!.videoImage!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          Text.rich(
            TextSpan(
              text: '来自于：',
              style: TextStyle(fontSize: 14.sp),
              children: [
                // 可点击
                TextSpan(
                  text: controller.type == 1
                      ? controller.videoDetailData!.articleName
                      : controller.dynamicDetailData!.articleName!,
                  style: TextStyle(fontSize: 14.sp, color: kAppColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => controller.onJumpToFieldDetail(
                        controller.type == 1
                            ? controller.videoDetailData!.articleId!
                            : controller.dynamicDetailData!.articleId!),
                )
              ],
            ),
          ).paddingSymmetric(vertical: 20.w, horizontal: 20.w),
        ],
      ),
    );
  }
}
