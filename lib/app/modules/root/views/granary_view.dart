import 'package:badges/badges.dart';
import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/granary_list_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/granary_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class GranaryView extends GetView<GranaryController> {
  // 空粮仓
  Widget empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '你的粮仓尚未启用',
            style: TextStyle(fontSize: 18.sp, color: kAppBlackColor),
          ),
          Text(
            '购买认领田地后，粮仓才能启用哦~',
            style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
          ),
        ],
      ),
    );
  }

  // 当前田地
  Widget currentField() {
    return Image.network(controller.granary.image!,
        height: 200, fit: BoxFit.fitWidth);
  }

  // 仓库item
  Widget granaryItem(GranaryItemModel data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            clipBehavior: Clip.hardEdge,
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
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 21.w),
                  padding: EdgeInsets.only(top: 42.w),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25.5.w),
                        child: Text(
                          data.name ?? '暂无名称',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: KWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DefaultTextStyle(
                              style: TextStyle(
                                  color: KWhiteColor, fontSize: 12.sp),
                              child: Column(
                                children: [
                                  Text('剩余库存'),
                                  Text('${data.residueNum ?? '0'}'),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              height: 20.h,
                              width: 0.5.w,
                              decoration: BoxDecoration(color: KWhiteColor),
                            ),
                            DefaultTextStyle(
                              style: TextStyle(
                                  color: KWhiteColor, fontSize: 12.sp),
                              child: Column(
                                children: [
                                  Text('剩余保质期'),
                                  Text(
                                    data.ifExpire == 0
                                        ? '${data.expireTime}'
                                        : '已过期',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: data.ifExpire == 0
                                          ? KWhiteColor
                                          : Colors.red,
                                    ),
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

                // 捐赠/回收/去加工
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data.ifExpire == 0 && data.ifRecycle == 1) {
                                  controller
                                      .getCurrentPrice(data.recyclePrice!);
                                  Get.dialog(Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        recycleDialogContent(data, type: 1),
                                        Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Image.asset(
                                              R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                                              width: 35.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                  // Get.defaultDialog(
                                  //   titlePadding: EdgeInsets.only(
                                  //       top: 50,
                                  //       bottom: 15.h,
                                  //       left: 17.5.w,
                                  //       right: 17.5.w),
                                  //   content: recycleDialogContent(data),
                                  //   title:
                                  //       "目前的回收价格为${data.recyclePrice}元/${data.units} 请选择你要回收的数量",
                                  //   titleStyle: TextStyle(
                                  //       color: Color(0xff666666),
                                  //       fontSize: 15.sp),
                                  //   radius: 10.w,
                                  // );
                                }
                              },
                              child: Image.asset(
                                  data.ifExpire == 0 && data.ifRecycle == 1
                                      ? R.ASSETS_ICONS_GRANARY_HUISHOU_PNG
                                      : R.ASSETS_ICONS_GRANARY_BUHUISHOU_PNG,
                                  width: 50.w),
                            ),
                            SizedBox(width: 13.5),
                            GestureDetector(
                              onTap: () {
                                if (data.ifExpire == 0) {
                                  controller
                                      .getCurrentPrice(data.recyclePrice!);
                                  Get.dialog(Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        recycleDialogContent(data, type: 2),
                                        Padding(
                                          padding: EdgeInsets.only(top: 14.h),
                                          child: GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Image.asset(
                                              R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                                              width: 35.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                }
                              },
                              child: Image.asset(
                                data.ifExpire == 0
                                    ? R.ASSETS_ICONS_GRANARY_JUANZENG_PNG
                                    : R.ASSETS_ICONS_GRANARY_UN_JUANZENG_PNG,
                                width: 50.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        // onTap: () => data.ifExpire == 0 && data.ifRecycle == 1
                        //     ? controller.onProcess(data.id!)
                        //     : null,
                        onTap: () => data.ifProcess == 0
                            ? (data.ifExpire == 0
                                ? controller.onProcess(data.id!)
                                : null)
                            : null,
                        child: Container(
                          decoration: BoxDecoration(
                              // color: data.ifExpire == 0 && data.ifRecycle == 1
                              color: data.ifProcess == 0
                                  ? (data.ifExpire == 0
                                      ? Colors.orange
                                      : Colors.grey)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text('加工/兑换',
                              style:
                                  TextStyle(fontSize: 16, color: KWhiteColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.forwardOperationRecords(data.id!),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      '操作记录 >',
                      style: TextStyle(fontSize: 13.sp, color: kAppGrey66Color),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(R.ASSETS_ICONS_GRANARY_GRANARY_BG_PNG),
                fit: BoxFit.cover,
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: KWhiteColor),
              child: Column(
                children: [
                  Text('${data.createtime}', style: TextStyle(fontSize: 13.sp)),
                  Text('${data.totalNum}', style: TextStyle(fontSize: 11.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // type: 1 回收; 2 捐赠
  Widget recycleDialogContent(GranaryItemModel data, {int type = 1}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          if (type == 2)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Text('你确定要将以下数量的库存交由农副仓，并无偿捐赠给需要的人吗？',
                  textAlign: TextAlign.center),
            ),
          if (type == 1)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    '目前的回收价格为${data.recyclePrice}/${data.units}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '请选择你要回收的数量',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 80.w),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff666666)),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.onDecrement(data.recyclePrice!),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.5),
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide()),
                      ),
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff999999)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TextField(
                        controller: controller.textEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // suffixText: '${data.units}',
                          isDense: true,
                          hintText: '请输入数值',
                          hintStyle: TextStyle(
                            color: Color(0xffBBBBBB),
                            fontSize: 16.sp,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onIncrement(data.recyclePrice!),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.5),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide()),
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff999999)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '剩余库存${data.residueNum}${data.units}',
            style: TextStyle(color: kAppGrey66Color),
          ).paddingOnly(bottom: 20.h),
          if (type == 1)
            GetBuilder<GranaryController>(builder: (_) {
              return Text.rich(TextSpan(
                  text: '本次回收您将获得：',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '${_.totalPrice}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '元',
                      style:
                          TextStyle(color: Color(0xff999999), fontSize: 13.sp),
                    ),
                  ]));
            }),
          GestureDetector(
            onTap: () {
              if (type == 1) {
                controller.onRecycle(data.id!);
              } else if (type == 2) {
                controller.onDonate(data.id!);
              }
            },
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 17.5.sp, vertical: 20.sp),
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff8AC036),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${type == 1 ? '确定回收' : '确定捐赠'}',
                  style: TextStyle(color: KWhiteColor, fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _granaryList() {
    return EasyRefresh.builder(
      controller: controller.easyRefreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView.builder(
          physics: physics,
          itemCount: controller.granary.granaryList!.length,
          itemBuilder: (BuildContext context, int index) {
            // return _granaryItem(controller.granary.granaryList![index]);
            return Text('2');
          },
        );
      },
      // childBuilder: (context, physics) {
      //   return NestedScrollView(
      //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //       return [
      //         const HeaderLocator.sliver(clearExtent: false),
      //       ];
      //     },
      //     physics: physics,
      //     body: ListView(
      //       physics: physics,
      //       children: [
      //         Stack(
      //           children: [
      //             currentField(),
      //             if (controller.granary.granaryList!.isNotEmpty)
      //               Positioned(
      //                 left: 0,
      //                 bottom: 0,
      //                 right: 0,
      //                 top: 0,
      //                 child: _granaryList(),
      //               )
      //           ],
      //         )
      //       ],
      //     ),
      //   );
      // },
      // childBuilder: (_, physics) {
      //   return CustomScrollView(
      //     physics: physics,
      //     slivers: [
      //       Stack(
      //         children: [
      //           currentField(),
      //           if (controller.granary.granaryList!.isNotEmpty)
      //             Positioned(
      //                 left: 0,
      //                 bottom: 0,
      //                 right: 0,
      //                 top: 0,
      //                 child: Padding(
      //                   padding: EdgeInsets.only(top: 140.w),
      //                   child: ListView.builder(
      //                     physics: NeverScrollableScrollPhysics(),
      //                     itemCount: controller.granary.granaryList!.length,
      //                     itemBuilder: (context, index) {
      //                       return granaryItem(
      //                           controller.granary.granaryList![index]);
      //                     },
      //                   ),
      // child: SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //     (context, index) => granaryItem(
      //         controller.granary.granaryList![index]),
      //     childCount:
      //         controller.granary.granaryList!.length,
      //   ),
      // ),
      // ))
      //   ],
      // ),
      // SliverPadding(
      //   padding: EdgeInsets.only(top: 0),
      //   sliver: SliverList(
      //     delegate: SliverChildBuilderDelegate(
      //       (context, index) =>
      //           granaryItem(controller.granary.granaryList![index]),
      //       childCount: controller.granary.granaryList!.length,
      //     ),
      //   ),
      // )
      // ],
      // );
      // },
    );
  }

  Widget get moreFieldList {
    return Container(
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.w),
          topRight: Radius.circular(14.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(R.ASSETS_ICONS_GRANARY_CLOSE_ICON_PNG,
                        width: 20.w),
                  ),
                ],
              ),
            ),
            Text(
              '${controller.granary.articleTitle}',
              style: TextStyle(color: Color(0xff8BBF37), fontSize: 18.sp),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.granary.articleList!.length,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.5.w),
                    child: GestureDetector(
                      onTap: () {
                        controller.getGranaryList(
                            fieldId: controller
                                .granary.articleList![index].articleId!);
                        Get.back();
                      },
                      child: Row(
                        children: [
                          Text(
                            '${controller.granary.articleList![index].articleTitle}',
                            style: TextStyle(
                                color: Color(0xff666666), fontSize: 20.sp),
                          ),
                          if (controller.granary.articleList![index].ifShow ==
                              1)
                            Container(
                              width: 6.w,
                              height: 6.w,
                              margin: EdgeInsets.only(left: 5.w),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: Get.back,
              child: Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                    horizontal: 30.w, vertical: Get.mediaQuery.padding.bottom),
                padding: EdgeInsets.symmetric(vertical: 11.w, horizontal: 70.w),
                decoration: BoxDecoration(
                  color: Color(0xff8BBF37),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Center(
                  child: Text(
                    '确定',
                    style: TextStyle(color: KWhiteColor, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildSearch {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        margin: EdgeInsets.symmetric(horizontal: 13.5.w),
        decoration: BoxDecoration(
          color: Color(0xff000000).withOpacity(.2),
          borderRadius: BorderRadius.circular(40.w),
        ),
        child: Row(
          children: [
            Expanded(
              child: GetBuilder<GranaryController>(builder: (c) {
                return Text('${controller.granary.articleTitle}',
                    style: TextStyle(color: KWhiteColor, fontSize: 11.sp));
              }),
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(moreFieldList);
              },
              child: Text('   |    其他粮仓 > ',
                  style: TextStyle(color: KWhiteColor, fontSize: 11.sp)),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _body {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          currentField(),
          if (controller.granary.granaryList!.isNotEmpty)
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              top: 0,
              child: _granaryList(),
            )
        ],
      ),
    );
  }

  PreferredSizeWidget get _buildAppbar {
    return BrnAppBar(
      backgroundColor: kAppColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          _buildSearch,
          GestureDetector(
            onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
            child: Badge(
              position: BadgePosition(top: -6, start: 14.w),
              showBadge: controller.granary.messageCount! > 0,
              badgeContent: Text(
                '${controller.granary.messageCount}',
                style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
              ),
              child: Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                  width: 25.w),
            ),
          ).paddingSymmetric(horizontal: 6.w),
          // GestureDetector(
          //   onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
          //   child: Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
          //       width: 25.w),
          // ).paddingSymmetric(horizontal: 6.w),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget _body2() {
    return EasyRefresh(
      controller: controller.easyRefreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: currentField(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100.w),
                  child: granaryItem(controller.granary.granaryList![0]),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return granaryItem(controller.granary.granaryList![index + 1]);
              },
              childCount: controller.granary.granaryList!.length - 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body3() {
    return EasyRefresh.builder(
      controller: controller.easyRefreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView.builder(
          shrinkWrap: true,
          physics: physics,
          itemCount: controller.granary.granaryList!.length,
          itemBuilder: (BuildContext context, int index) {
            return granaryItem(controller.granary.granaryList![index]);
          },
        );
      },
    );
  }

  Widget _body4() {
    return GetBuilder<GranaryController>(
        id: 'onFieldOffsetChange',
        builder: (_) {
          return Stack(
            children: [
              Transform.translate(
                offset: Offset(0, -_.currentFieldOffset.toDouble()),
                child: currentField(),
              ),
              Positioned(
                top: 140,
                bottom: 0,
                left: 0,
                right: 0,
                child: ListView.builder(
                  controller: _.scrollController,
                  // padding: EdgeInsets.only(top: 130),
                  // physics: physics,
                  itemCount: _.granary.granaryList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return granaryItem(_.granary.granaryList![index]);
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget _body5() {
    return EasyRefresh.builder(
      controller: controller.easyRefreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      childBuilder: (BuildContext context, ScrollPhysics physics) {
        return ListView.builder(
          shrinkWrap: true,
          physics: physics,
          itemCount: controller.granary.granaryList!.length,
          itemBuilder: (BuildContext context, int index) {
            // 如果是第一个item,则在上面加一个currentField()，否则直接返回item
            if (index == 0) {
              return Column(
                children: [
                  currentField(),
                  granaryItem(controller.granary.granaryList![index]),
                ],
              );
            }
            return granaryItem(controller.granary.granaryList![index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KWhiteColor,
        appBar: _buildAppbar,
        body: controller.obx(
          (state) => _body2(),
          // (state) => _granaryList(),
          onLoading: Center(child: BrnPageLoading()),
          onEmpty: empty(),
          onError: (value) => GestureDetector(
            onTap: controller.getGranaryList,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: kAppColor,
                ),
                alignment: Alignment.center,
                child: Text(
                  value ?? '点击刷新',
                  style: TextStyle(color: KWhiteColor, fontSize: 16.sp),
                ),
              ),
            ),
          ),
        ));
  }
}
