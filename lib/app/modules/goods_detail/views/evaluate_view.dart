import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/goods_detail/controllers/goods_detail_controller.dart';
import 'package:mallxx_app/const/colors.dart';

class EvaluateView extends GetView<GoodsDetailController> {
  const EvaluateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: GetBuilder<GoodsDetailController>(
        builder: (c) {
          return EasyRefresh.builder(
            controller: c.commentEasyRefreshController,
            onLoad: c.onGoodsCommentLoadMore,
            childBuilder: (_, physics) {
              return c.commentList.isNotEmpty
                  ? CustomScrollView(
                      physics: physics,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => buildItem(c.commentList[index]),
                            childCount: c.commentList.length,
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text('暂无评价'));
            },
          );
        },
      ),
    );
  }

  Widget buildItem(GoodsCommentItemModel m) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.5.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.w,
                  backgroundImage: NetworkImage(m.memberImg!),
                ).paddingOnly(right: 8.w),
                Expanded(
                  child: Text(m.memberName!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
                Text(m.createtime!,
                    style: TextStyle(fontSize: 11.sp, color: kAppGrey66Color)),
              ],
            ),
          ),
          Text(m.contents!, style: TextStyle(fontSize: 14.sp, height: 1.6.h)),
        ],
      ),
    );
  }
}
