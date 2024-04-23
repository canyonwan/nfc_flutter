import 'package:badges/badges.dart';
import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '/app/models/field_list_model.dart';
import '/app/modules/root/controllers/field_controller.dart';

// 田地
class FieldView extends GetView<FieldController> {
  // 左侧分类菜单
  Widget _buildLeftMenus() {
    List<FieldCategoryItemModel> categories = controller.categoryList;
    return Container(
      color: kBgGreyColor,
      width: 90.5.w,
      height: Get.height,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_, index) => _buildMenu(categories[index]),
      ),
    );
  }

  Widget _buildMenu(FieldCategoryItemModel model) {
    return GetBuilder<FieldController>(
        id: 'updateMenuId',
        builder: (_) {
          return GestureDetector(
            onTap: () => _.onSetMenu(model),
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 90.5.w),
                  child: Container(
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    color: model.id == _.searchModel.listId
                        ? KWhiteColor
                        : kBgGreyColor,
                    alignment: Alignment.center,
                    child: Text(
                      '${model.name}',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: model.id == _.searchModel.listId
                              ? kAppBlackColor
                              : kAppSubGrey99Color),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: model.ifShow == 1
                      ? GFBadge(
                          child: Text('${model.count}'),
                        )
                      : SizedBox(),
                ),
              ],
            ),
          );
        });
  }

  Widget categoryTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFieldList() {
    List<FieldItemModel> fields = controller.fieldList;
    if (fields.isEmpty) {
      return Stack(
        children: [
          if (controller.dataModel.ifIncrease == 1) _buildTransferBox(),
          Center(
              child: Text('该地区暂无相关农场',
                  style: TextStyle(color: kAppGrey66Color, fontSize: 13.sp))),
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Obx(() {
          if (controller.isLoading == true) {
            return Center(child: BrnPageLoading());
          } else
            return Container(
              color: KWhiteColor,
              child: Column(
                children: [
                  // 需求先去掉
                  // if (controller.dataModel.labelIds!.isNotEmpty) _buildLabels(),
                  _buildFieldListBox(fields)
                ],
              ),
            );
        }),
        Align(child: _buildAllLabels()),
      ],
    );
  }

  Container _buildTransferBox() {
    return Container(
      height: 40.w,
      width: double.infinity,
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        gradient: LinearGradient(colors: [
          Color(0xffFFCA6E),
          Color(0xffF9DA90),
        ]),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(13, 13, 13, 0.2),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '凭编码和转移码手动添加',
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
          ),
          GestureDetector(
            onTap: () {
              Get.dialog(Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.5.w, vertical: 18.w),
                      margin: EdgeInsets.symmetric(
                          horizontal: 17.5.w, vertical: 12.w),
                      decoration: BoxDecoration(
                        color: KWhiteColor,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller.codeController,
                            decoration: InputDecoration(
                              hintText: '请输入编码',
                              hintStyle: TextStyle(color: kAppSubGrey99Color),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.w),
                          TextField(
                            controller: controller.transferController,
                            decoration: InputDecoration(
                              hintText: '请输入转移码',
                              hintStyle: TextStyle(color: kAppSubGrey99Color),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.w),
                          GestureDetector(
                            onTap: controller.onConfirmTransfer,
                            child: Container(
                              margin: EdgeInsets.all(10.w),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: kAppColor,
                                borderRadius: BorderRadius.circular(30.w),
                              ),
                              child: Text('确认添加',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
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
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: Color(0xffF4990E),
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Text('添加',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  // 田地列表ListView
  Widget _buildFieldListBox(List<FieldItemModel> fields) {
    return Expanded(
      child: EasyRefresh.builder(
        controller: controller.easyRefreshController,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (_, physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildField(fields[index]),
                  childCount: fields.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // 全部标签
  Widget _buildAllLabels() {
    return Offstage(
      offstage: controller.showAllLabels.isTrue,
      child: Container(
        color: Color(0x72000000),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.5.w, vertical: 9.5.w),
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.w),
                  bottomRight: Radius.circular(20.w),
                ),
              ),
              child: Column(
                children: [
                  Wrap(
                    children: controller.dataModel.labelIds!
                        .map((e) => _buildLabelItem(e))
                        .toList(),
                  ),
                  Divider(),
                  BrnIconButton(
                    widgetHeight: 20.h,
                    direction: Direction.right,
                    name: '点击收起',
                    iconWidget: Icon(Icons.keyboard_arrow_up_outlined,
                        color: kAppSubGrey99Color, size: 14.w),
                    onTap: () => controller.onShowAllLabels(false),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabels() {
    return GetBuilder<FieldController>(builder: (c) {
      List<LabelItemModel> labelIds = c.dataModel.labelIds ?? [];
      return Container(
        padding: EdgeInsets.only(
          left: 10.5.w,
          right: 8.5.w,
          top: 8.w,
          bottom: 6.w,
        ),
        width: Get.width,
        height: 32.h,
        color: KWhiteColor,
        child: Row(
          children: [
            Wrap(
              children: labelIds.length > 3
                  ? labelIds
                      .sublist(0, 3)
                      .map((e) => _buildLabelItem(e))
                      .toList()
                  : labelIds.map((e) => _buildLabelItem(e)).toList(),
            ),
            GestureDetector(
              onTap: () => c.onShowAllLabels(true),
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                color: Color(0xffDCF8FF),
                child: Icon(Icons.keyboard_arrow_down_rounded,
                    color: Color(0xffB1BABD)),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLabelItem(LabelItemModel model) {
    return GetBuilder<FieldController>(builder: (c) {
      return GestureDetector(
        onTap: () => c.onSelectLabel(model.id!),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.w),
          margin: EdgeInsets.only(right: 8.w, bottom: 4.w),
          decoration: BoxDecoration(
            color: c.searchModel.labelId == model.id
                ? Color.fromRGBO(78, 88, 82, .1)
                : kBgGreyColor,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Text(model.name!,
              style: TextStyle(
                  color: c.searchModel.labelId == model.id
                      ? kAppColor
                      : kAppSubGrey99Color)),
        ),
      );
    });
  }

  InkWell _buildField(FieldItemModel item) {
    return InkWell(
      onTap: () {
        controller.onFieldDetail(item);
      },
      child: GetBuilder<FieldController>(
          id: 'updateFieldItem',
          builder: (_) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(7.5.w),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(13, 13, 13, 0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.image != null && item.image!.length > 0)
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.5.w),
                              topRight: Radius.circular(7.5.w),
                            ),
                          ),
                          child: Image(
                            image: NetworkImage(item.image!),
                            height: 140.0,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 11.5.w, bottom: 2.h, top: 4.h),
                        child: Text(
                          item.title!,
                          style: TextStyle(
                            color: Color(0xff606060),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          BrnIconButton(
                            widgetWidth: 60.w,
                            widgetHeight: 20.h,
                            iconWidget:
                                Image.asset(R.ASSETS_ICONS_FIELD_BROWSE_PNG),
                            iconWidth: 14.w,
                            name: '${item.basicsBrowse}',
                            direction: Direction.left,
                          ),
                          BrnIconButton(
                            widgetWidth: 60.w,
                            widgetHeight: 20.h,
                            iconWidget: Image.asset(
                                item.ifLike == 0
                                    ? R.ASSETS_ICONS_FIELD_SHOUCANG_PNG
                                    : R.ASSETS_ICONS_FIELD_SHOUCANG_PNG,
                                color: item.ifLike == 0
                                    ? kBgGreyColor
                                    : Colors.red),
                            direction: Direction.left,
                            name: '${item.basicsEnshrine}',
                            iconWidth: 14.w,
                            onTap: () => controller.onCollectField(item),
                          ),
                          BrnIconButton(
                            widgetWidth: 60.w,
                            widgetHeight: 20.h,
                            iconWidget:
                                Image.asset(R.ASSETS_ICONS_FIELD_RATE_ON_PNG),
                            direction: Direction.left,
                            name: '${item.basicsGrade}分',
                            iconWidth: 14.w,
                          ),
                          BrnIconButton(
                            widgetWidth: 60.w,
                            widgetHeight: 20.h,
                            iconWidget: Image.asset(
                                R.ASSETS_ICONS_FIELD_JINGYINGSHIJIAN_PNG),
                            direction: Direction.left,
                            name: '${item.basicsYear}年',
                            iconWidth: 14.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 4.w,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 6.5.h, horizontal: 13.5.w),
                    decoration: BoxDecoration(
                      color: kAppColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.5.w),
                        bottomRight: Radius.circular(5.w),
                      ),
                    ),
                    child: Text(
                      '${item.describe}',
                      style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
                    ),
                  ),
                ),
                Positioned(
                  top: 4.h,
                  right: 8.w,
                  child: item.ifShow == 1
                      ? GFBadge(
                          child: Text("${item.count}"),
                        )
                      : SizedBox(),
                ),
              ],
            );
          }),
    );
  }

  PreferredSizeWidget get _buildAppbar {
    return BrnAppBar(
      backgroundColor: kAppColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GetBuilder<FieldController>(
              id: 'update_location',
              builder: (_) {
                return GestureDetector(
                  onTap: () => _.onSelectAddress(true),
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      Image.asset(
                        R.ASSETS_ICONS_FIELD_LOCATION_ICON_AT_2X_PNG,
                        width: 16.w,
                      ),
                      SizedBox(width: 4.w),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          _.searchModel.mergename != ',,,null'
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
          _buildSearch,
          GestureDetector(
            onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
            child: Badge(
              position: BadgePosition(top: -6, start: 14.w),
              showBadge: controller.dataModel.messageCount > 0,
              badgeContent: Text(
                '${controller.dataModel.messageCount}',
                style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
              ),
              child: Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                  width: 25.w),
            ),
          ).paddingSymmetric(horizontal: 6.w),
          // GestureDetector(
          //         onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
          //         child: Image.asset(
          //             R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
          //             width: 25.w))
          //     .paddingSymmetric(horizontal: 6.w),
          GestureDetector(
            onTap: controller.shareToSession,
            child:
                Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG, width: 25.w),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget get _buildSearch {
    return Expanded(
      child: GestureDetector(
        onTap: controller.onToSearch,
        child: Container(
          padding: EdgeInsets.only(left: 20.w),
          //margin: EdgeInsets.symmetric(horizontal: 30.w),
          // margin: const EdgeInsets.only(left: 20),
          //width: 10.w,
          decoration: BoxDecoration(
            color: KWhiteColor,
            borderRadius: BorderRadius.circular(40.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Image.asset(R.ASSETS_ICONS_FIELD_SEARCH_ICON_PNG, width: 14.w),
                GetBuilder<FieldController>(
                    id: 'updateSearch',
                    builder: (c) {
                      return Text(
                              '${c.searchModel.search == '' ? '搜索' : c.searchModel.search}',
                              style: TextStyle(
                                  fontSize: 14.sp, color: kAppSubGrey99Color))
                          .paddingOnly(left: 10.w);
                    }),
              ]),
              Container(
                padding: EdgeInsets.all(6.5.w),
                decoration: BoxDecoration(
                  color: Color(0xffECF5F2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.w),
                    bottomRight: Radius.circular(40.w),
                  ),
                ),
                child: Text('搜索',
                    style: TextStyle(fontSize: 11.sp, color: kAppColor)),
              ),
            ],
          ),
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
        body: Obx(() {
          if (controller.initLoading == true) {
            return Center(child: BrnPageLoading());
          } else {
            if (controller.searchModel.mergename!.isEmpty) {
              return Center(child: BrnAbnormalStateWidget(title: '获取定位数据失败'));
            } else
              return Row(
                children: [
                  _buildLeftMenus(),
                  Expanded(child: _buildFieldList())
                ],
              );
          }
        }),
      ),
    );
  }
}
