import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/app/modules/message_center/views/message_detail.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/message_center_controller.dart';

class MessageCenterView extends GetView<MessageCenterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('消息'),
        centerTitle: true,
        actions: [
          GFButton(
            onPressed: controller.onClearMessage,
            text: '清除未读',
            color: KWhiteColor,
            type: GFButtonType.transparent,
          ),
        ],
      ),

      // body: buildListView(),
      body: controller.obx(
        (state) => EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: controller.onRefresh,
          onLoad: controller.onLoadMore,
          childBuilder: (_, physics) {
            return GetBuilder<MessageCenterController>(builder: (c) {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  SliverToBoxAdapter(child: _buildTop(state!)),
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
    return GestureDetector(
      onTap: () => Get.to(() => MessageDetail(type: m.type!, id: m.id!)),
      child: Container(
        color: KWhiteColor,
        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
        child: Row(
          children: [
            GFIconBadge(
              child: Image.network(m.images!, width: 50.w),
              counterChild: m.ifRead == 1
                  ? GFBadge(
                      size: 14.w,
                      shape: GFBadgeShape.circle,
                    )
                  : SizedBox(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${m.title}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      Text(
                        '${m.createtime}',
                        style: TextStyle(
                            fontSize: 12.sp, color: kAppSubGrey99Color),
                      ),
                    ],
                  ),
                  Text(
                    '${m.describe}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kAppGrey66Color,
                    ),
                  ).paddingOnly(top: 8.5.w),
                ],
              ).paddingSymmetric(horizontal: 10.w),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTop(NoticeDatatModel m) {
    return Container(
      height: 150.w,
      child: Stack(
        children: [
          Container(
            height: 80.w,
            color: kAppColor,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 10.w,
            child: Container(
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(13, 13, 13, 0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 21.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GFIconBadge(
                    child: GestureDetector(
                      onTap: () => controller.onViewSystemNotice(1),
                      child: Image.asset(R.ASSETS_ICONS_MINE_XITONGTONGZHI_PNG,
                          width: 50.w),
                    ),
                    counterChild: m.noticeCount == 0
                        ? SizedBox()
                        : GFBadge(child: Text('${m.noticeCount}')),
                  ),
                  GFIconBadge(
                    child: GestureDetector(
                      onTap: () => controller.onViewSystemNotice(2),
                      child: Image.asset(R.ASSETS_ICONS_MINE_JIAOYIWULIU_PNG,
                          width: 50.w),
                    ),
                    counterChild: m.messageCount == 0
                        ? SizedBox()
                        : GFBadge(child: Text('${m.messageCount}')),
                  ),
                  GestureDetector(
                    // onTap: () => Get.toNamed(Routes.MEIQIA_CHAT),
                    onTap: controller.callChat,
                    child: Image.asset(R.ASSETS_ICONS_MINE_ZAIXIANKEFU_PNG,
                        width: 50.w),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
