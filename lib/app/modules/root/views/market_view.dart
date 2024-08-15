import 'package:badges/badges.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/goods_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/modules/root/controllers/market_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class MarketView extends GetView<MarketController> {
  Widget _buildGoodsItem(GoodsItemModel model) {
    return GestureDetector(
      onTap: () => controller.onToDetail(model.id!),
      child: Container(
        margin: EdgeInsets.all(10.5.w),
        color: KWhiteColor,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w),
              width: 154.w,
              height: 154.w,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(7.5.w)),
              child: model.ifSellOut == 1
                  ? Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.black.withOpacity(.6),
                                Colors.white
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds);
                          },
                          child: Image(
                            image: NetworkImage(model.goodsImage!),
                            fit: BoxFit.fill,
                            width: Get.width,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            color: Colors.black.withOpacity(.5),
                            alignment: Alignment.center,
                            child: Text('已卖完',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    )
                  : Image(
                      image: NetworkImage(model.goodsImage!),
                      fit: BoxFit.fill,
                      width: Get.width,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.goodsName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Text(
                    model.goodsRemark ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style:
                        TextStyle(color: kAppSubGrey99Color, fontSize: 12.sp),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '¥',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10.sp,
                      ),
                      children: [
                        TextSpan(
                          text: model.goodsPrice,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' /箱',
                          style: TextStyle(
                            color: kAppSubGrey99Color,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 10.5, bottom: 4.w),
                  //
                  _buildSpecialPrice(model.exclusivePrice ?? '0'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '销量: ${model.salesVolume}',
                        style: TextStyle(
                            fontSize: 10.sp, color: kAppSubGrey99Color),
                      ),
                      Text(
                        '评价: ${model.evaluationNumber}',
                        style: TextStyle(
                            fontSize: 10.sp, color: kAppSubGrey99Color),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 优源专享
  Widget _buildSpecialPrice(String price) {
    return Row(
      children: [
        Text('优源专享', style: TextStyle(fontSize: 11.sp)),
        BubbleBox(
          shape: BubbleShapeBorder(
            border: BubbleBoxBorder(
              color: Color(0xffF8B041),
              width: 3,
            ),
            position: const BubblePosition.center(0),
            direction: BubbleDirection.left,
          ),
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          backgroundColor: Color(0xffF8B041),
          child: Text.rich(
            TextSpan(
              text: '¥',
              style: TextStyle(
                color: KWhiteColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: price,
                  style: TextStyle(
                    color: KWhiteColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildEmpty {
    return SliverToBoxAdapter(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.only(top: 100.h),
        child: Column(
          children: [
            Image.asset(R.ASSETS_ICONS_MARKET_GOODS_LIST_EMPTY_PNG,
                width: 154.w, fit: BoxFit.cover),
            Text(
              '暂无商品',
              style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
            ).paddingOnly(top: 12.w),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String value) {
    return GestureDetector(
      onTap: controller.getGoodsList,
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
            value,
            style: TextStyle(color: KWhiteColor, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Expanded(
      child: GetBuilder<MarketController>(builder: (c) {
        return EasyRefresh.builder(
          controller: c.easyRefreshController,
          onRefresh: c.onRefresh,
          onLoad: c.onLoadMore,
          childBuilder: (_, physics) {
            return CustomScrollView(
              controller: c.scrollController,
              physics: physics,
              slivers: [
                c.browserLayout
                    ? c.goodsList.isNotEmpty
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _buildGoodsItem(c.goodsList[index]),
                              childCount: c.goodsList.length,
                            ),
                          )
                        : _buildEmpty
                    : c.goodsList.isNotEmpty
                        ? buildGridView(c.goodsList)
                        : _buildEmpty,
              ],
            );
          },
        );
      }),
    );
  }

  Widget buildGridView(List<GoodsItemModel> goodsList) {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20.w,
      // crossAxisSpacing: 10.w,
      childAspectRatio: .68,
      children: goodsList.map((item) => buildGridItem(item)).toList(),
    );
  }

  Widget buildGridItem(GoodsItemModel model) {
    return GestureDetector(
      onTap: () => controller.onToDetail(model.id!),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
            height: 154.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.5.w),
                topRight: Radius.circular(7.5.w),
              ),
            ),
            child: model.ifSellOut == 1
                ? Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.black.withOpacity(.6),
                              Colors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        child: Image(
                            image: NetworkImage(model.goodsImage!),
                            fit: BoxFit.fill,
                            width: Get.width),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4.w),
                          color: Colors.black.withOpacity(.5),
                          alignment: Alignment.center,
                          child: Text('已卖完',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )
                : model.ifTimeSell == 1
                    ? Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(.6),
                                  Colors.white
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: Image(
                                image: NetworkImage(model.goodsImage!),
                                fit: BoxFit.fill,
                                width: Get.width),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              color: Colors.black.withOpacity(.5),
                              alignment: Alignment.center,
                              child: Text('本时段不可售',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    : Image(
                        image: NetworkImage(model.goodsImage!),
                        fit: BoxFit.fill,
                        width: Get.width),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    model.goodsName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14.sp),
                  ).paddingOnly(right: 10.w),
                ),
                Text.rich(
                  TextSpan(
                    text: '¥',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                    children: [
                      TextSpan(
                        text: model.goodsPrice,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' /箱',
                        style: TextStyle(
                          color: kAppSubGrey99Color,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                //
                _buildSpecialPrice(model.exclusivePrice!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '销量: ${model.salesVolume}',
                      style:
                          TextStyle(fontSize: 10.sp, color: kAppSubGrey99Color),
                    ),
                    Text(
                      '评价: ${model.evaluationNumber}',
                      style:
                          TextStyle(fontSize: 10.sp, color: kAppSubGrey99Color),
                    ),
                  ],
                ).paddingOnly(right: 10.w)
              ],
            ),
          ),
        ],
      ).paddingOnly(left: 10.w),
    );
  }

  Container get buildSelection {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: GetBuilder<MarketController>(builder: (c) {
        return Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: c.selectionOptions
                    .map((e) => _buildSelectionItem(e))
                    .toList(),
              ).paddingSymmetric(horizontal: 22.5.w),
            ),
            GestureDetector(
              onTap: c.switchLayout,
              child: Image.asset(
                      controller.browserLayout
                          ? R.ASSETS_ICONS_MARKET_LAYOUT_LIST_PNG
                          : R.ASSETS_ICONS_MARKET_LAYOUT_GRID_PNG,
                      width: 20.w)
                  .paddingOnly(right: 16.5.w),
            ),
          ],
        );
      }),
    );
  }

  PreferredSizeWidget get buildAppBar {
    return AppBar(
      backgroundColor: kAppColor,
      automaticallyImplyLeading: false,
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<FieldController>(
              id: 'update_location',
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: GestureDetector(
                    onTap: controller.onChangeAddress,
                    child: Row(
                      children: [
                        //Icon(Icons.location_on_rounded).paddingOnly(right: 3.w),
                        Image.asset(
                          R.ASSETS_ICONS_FIELD_LOCATION_ICON_AT_2X_PNG,
                          width: 16.w,
                        ),
                        SizedBox(
                          width: 80.w,
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
                            style: TextStyle(fontSize: 16.sp),
                          ).paddingOnly(left: 5.w, right: 10.w),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          _buildSearch,
          GestureDetector(
            onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
            child: Badge(
              position: BadgePosition(top: -6, start: 14.w),
              showBadge: controller.goodsListDataModel.ifMessageShow == 1 &&
                  controller.goodsListDataModel.messageCount! > 0,
              badgeContent: Text(
                '${controller.goodsListDataModel.messageCount}',
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
          //     .paddingSymmetric(horizontal: 5.w)
          // .paddingOnly(left: 8.w),
          GestureDetector(
            onTap: controller.shareToSession,
            child:
                Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG, width: 25.w),
          ),
          //SizedBox(width: 8.w),
        ],
      ),
    );
  }

  Widget get _buildSearch {
    return GestureDetector(
      onTap: controller.onSearch,
      child: Container(
        width: 180.w,
        padding: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(40.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset(R.ASSETS_ICONS_FIELD_SEARCH_ICON_PNG, width: 12.w),
              GetBuilder<MarketController>(
                  id: 'updateSearch',
                  builder: (c) {
                    return Text(
                            '${c.searchModel.keyword == '' ? '搜索' : c.searchModel.keyword}',
                            style: TextStyle(
                                fontSize: 12.sp, color: kAppSubGrey99Color))
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildNestedView,
      backgroundColor: KWhiteColor,
      appBar: buildAppBar,
      body: _buildBody(),

      // body: GetBuilder<MarketController>(builder: (c) {
      //   if (c.goodsList.isEmpty) {
      //     return _buildEmpty;
      //   }
      //   return _buildBody(c);
      // }),
    );
  }

  Widget get _buildNestedView {
    return Stack(
      children: [
        _buildFloatingButtonGroup,
      ],
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        buildSelection,
        buildListView(),
      ],
    );
  }

  Widget get _buildFloatingButtonGroup {
    return GetBuilder<MarketController>(
        id: 'update_goods_count',
        builder: (c) {
          return Positioned(
            bottom: 0.w,
            right: 0.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.SHOP_CART),
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

  Widget _buildSelectionItem(SelectionModel e) {
    return GetBuilder<MarketController>(builder: (c) {
      return GestureDetector(
        onTap: () => c.onSwitchSelection(e),
        child: Row(
          children: [
            Text(e.name!,
                style: TextStyle(
                  fontSize: 15.sp,
                  color:
                      e.type == c.searchModel.type ? kAppColor : kAppBlackColor,
                )).paddingOnly(right: 4.w),
            e.icon != ''
                ? Image.asset(e.icon!, width: 8.w, fit: BoxFit.cover)
                : SizedBox()
          ],
        ),
      );
    });
  }
}
