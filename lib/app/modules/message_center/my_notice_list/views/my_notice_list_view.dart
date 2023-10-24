import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/my_notice_list_controller.dart';

class MyNoticeListView extends GetView<MyNoticeListController> {
  const MyNoticeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.type == 1 ? '系统通知' : '交易物流'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: controller.onRefresh,
          onLoad: controller.onLoadMore,
          childBuilder: (_, physics) {
            return GetBuilder<MyNoticeListController>(builder: (c) {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  c.messageList.isNotEmpty
                      ? buildSliverList(c.messageList)
                      : SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(top: 200.w),
                            alignment: Alignment.center,
                            child: Text('暂无消息'),
                          ),
                        ),
                ],
              );
            });
          },
        ),
        onLoading: BrnPageLoading(),
      ),
    );
  }

  Widget buildSliverList(List<NoticeItemModel> list) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => buildMessageItem(list[index]),
          childCount: list.length,
        ),
      );

  Widget buildMessageItem(NoticeItemModel m) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
            margin: EdgeInsets.only(bottom: 10.w),
            decoration: BoxDecoration(
              color: kAppSubGrey99Color,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Text('${m.createtime}',
                style: TextStyle(color: KWhiteColor, fontSize: 11.sp)),
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.w),
            decoration: BoxDecoration(
              color: KWhiteColor,
              borderRadius: BorderRadius.circular(7.w),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text('${m.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16.sp))),
                    Text('${m.createtime}',
                            style: TextStyle(
                                color: kAppSubGrey99Color, fontSize: 12.sp))
                        .paddingOnly(left: 10.w),
                  ],
                ).paddingOnly(bottom: 10.w),
                //
                Container(
                  decoration: BoxDecoration(
                    color: kBgGreyColor,
                    borderRadius: BorderRadius.circular(7.w),
                  ),
                  child: Row(
                    children: [
                      Image.network('${m.images}',
                              width: 100.w, height: 70.w, fit: BoxFit.cover)
                          .paddingOnly(right: 4.w),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${m.describe}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
