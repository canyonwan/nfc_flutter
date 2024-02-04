import 'package:badges/badges.dart';
import 'package:bruno/bruno.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/components/number_item.dart';
import 'package:mallxx_app/app/components/swiper_pagination.dart';
import 'package:mallxx_app/app/models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/goods_detail/views/cookbook_evaluate_view.dart';
import 'package:mallxx_app/app/modules/goods_detail/views/detail_html_view.dart';
import 'package:mallxx_app/app/modules/goods_detail/views/evaluate_view.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:oktoast/oktoast.dart';

import '../controllers/goods_detail_controller.dart';

///
class GoodsDetailView extends GetView<GoodsDetailController> {
  const GoodsDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      bottomNavigationBar: _buildBottomButton,
      body: controller.obx(
        (state) => buildBody,
        onLoading: Center(child: BrnPageLoading()),
        onError: (e) => Center(child: Text(e!)),
      ),
    );
  }

  ExtendedNestedScrollView get buildBody {
    return ExtendedNestedScrollView(
      pinnedHeaderSliverHeightBuilder: () =>
          Get.mediaQuery.padding.top + kToolbarHeight,
      headerSliverBuilder: (_, bool innerBoxIsScrolled) {
        return [buildAppBar, _buildGoodsInfo];
      },
      body: Column(children: [_buildTabsBox, _buildTabBarView]),
    );
  }

  Widget get _buildGoodsInfo {
    return SliverToBoxAdapter(
      child: GetBuilder<GoodsDetailController>(builder: (c) {
        final data = c.dataModel;
        return Column(
          children: [
            _buildSwiper(data.secondaryImages!),
            if (data.isPresell == 1) _buildPreSale(data),
            Column(
              children: [
                _buildPrice(data),
                _buildGoodsDesc(data),
                Divider(),
                _buildRowText(
                  '规格',
                  rightChild: Text(
                    data.specification!,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
                Divider(),
                _buildRowText(
                  '送至',
                  rightChild: GetBuilder<FieldController>(
                    id: 'update_location',
                    builder: (_) {
                      return GestureDetector(
                        onTap: () => controller.onSelectAddress(),
                        child: SizedBox(
                          child: Text(
                            _.searchModel.mergename!.isNotEmpty
                                ? _.searchModel.mergename!
                                : '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      );
                    },
                  ),
                  // rightChild: GestureDetector(
                  //   onTap: c.onSelectAddress,
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           c.dataModel.mergename == ''
                  //               ? c.fieldController.searchModel.mergename!
                  //               : c.dataModel.mergename!,
                  //           style: TextStyle(fontSize: 13.sp),
                  //         ),
                  //       ),
                  //       Icon(Icons.keyboard_arrow_right_sharp,
                  //           color: kAppSubGrey99Color, size: 16.w)
                  //     ],
                  //   ),
                  // ),
                ),
                Divider(),
                _buildRowText(
                  '发货',
                  rightChild: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '运费: ${data.freightFirst}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13.sp, color: Colors.red),
                      ),
                      Text(
                        '${data.commodityReduction}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 13.sp, color: kAppGrey66Color),
                      ),
                      Text(
                        c.getStockStatus(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13.sp, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ).paddingSymmetric(horizontal: 19.5.w),
          ],
        );
      }),
    );
  }

  Widget _buildRowText(String title, {required Widget rightChild}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: kAppSubGrey99Color, fontSize: 14.sp),
        ).paddingOnly(right: 15.5.w),
        Expanded(child: rightChild),
      ],
    ).paddingSymmetric(vertical: 7.5.h);
  }

  // 商品简介
  Widget _buildGoodsDesc(GoodsDetailDataModel m) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  m.goodsName ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ).paddingOnly(top: 19.h, bottom: 10.5.h),
              ),
              if (m.isPresell == 1)
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Color(0xffFB9B0D),
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  child: Text('合买预约',
                      style: TextStyle(color: KWhiteColor, fontSize: 10.sp)),
                )
            ],
          ),
          if (m.goodsRemark != '')
            Text(
              m.goodsRemark!,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  fontSize: 13.sp, color: kAppGrey66Color, height: 1.4.h),
            ),
        ],
      ),
    );
  }

  Widget _buildPrice(GoodsDetailDataModel m) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text.rich(
              TextSpan(
                text: m.goodsPrice,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
                children: [
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
            _buildSpecialPrice(m.exclusivePrice!).paddingOnly(left: 10.5.w),
          ],
        ),
        Text('销量：${m.salesVolume}',
            style: TextStyle(fontSize: 11.sp, color: kAppGrey66Color))
      ],
    ).paddingOnly(top: 21.w);
  }

  // 是合买
  Widget _buildPreSale(GoodsDetailDataModel m) {
    // DateFormat.constructTime(seconds)
    // DateUtil.formatDateMs(m.salesVolume!);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.5.w, vertical: 9.5.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(R.ASSETS_IMAGES_PRESALE_BG_PNG),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '仅剩  ',
                          style: TextStyle(fontSize: 12.sp, color: KWhiteColor),
                          children: [
                            TextSpan(
                              text: '${m.residueNum}',
                              style: TextStyle(
                                color: KWhiteColor,
                                fontSize: 18.sp,
                              ),
                            ),
                            TextSpan(
                              text: ' 份',
                              style: TextStyle(
                                color: KWhiteColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 5.w),
                      Text('共合买：${m.presellTotalNum}份',
                          style: TextStyle(
                              fontSize: 12.sp, color: kAppGrey66Color)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => controller.onLaunchUrl(m.presellRuleUrl!),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                      decoration: BoxDecoration(
                        color: Color(0xff6D992D),
                        borderRadius: BorderRadius.circular(30.w),
                      ),
                      child: Text('查看规则',
                          style:
                              TextStyle(color: KWhiteColor, fontSize: 12.sp)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => Text.rich(
                    TextSpan(
                        text: '距结束：',
                        style: TextStyle(
                            color: kAppSubGrey99Color, fontSize: 11.sp),
                        children: [
                          TextSpan(
                            text:
                                '${controller.timeRemaining.split('天').first}天',
                            style: TextStyle(color: kAppColor, fontSize: 10.sp),
                          ),
                          TextSpan(
                              text:
                                  '${controller.timeRemaining.split('天').last}',
                              style: TextStyle(color: KWhiteColor)),
                        ]),
                  )).paddingOnly(left: 20.w, top: 4.w),
            )
          ],
        ));
  }

  // 优源专享
  Widget _buildSpecialPrice(String price) {
    return Row(
      children: [
        Text('优源专享', style: TextStyle(fontSize: 12.sp, color: kAppBlackColor)),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _buildSwiper(List<String> images) {
    return SizedBox(
      height: 275.h,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(images[index], fit: BoxFit.fill);
        },
        itemCount: images.length,
        pagination: new SwiperPagination(
          builder: new MyFractionPaginationBuilder(),
          alignment: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget get _buildTabsBox {
    return GetBuilder<GoodsDetailController>(builder: (c) {
      return BrnTabBar(
        controller: c.tabController,
        tabs: c.tabs,
        indicatorColor: kAppColor,
        labelStyle: TextStyle(
          color: kAppColor,
          fontSize: 17.5.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          color: kAppSubGrey99Color,
          fontSize: 17.5.sp,
        ),
      );
    });
  }

  Widget get _buildTabBarView {
    return GetBuilder<GoodsDetailController>(builder: (c) {
      return Expanded(
        child: TabBarView(
          controller: c.tabController,
          children: [
            EvaluateView(),
            DetailHtmlView(c.dataModel.content!),
            CookbookEvaluateView(),
          ],
        ),
      );
    });
  }

  Widget get _buildBottomButton {
    return GetBuilder<GoodsDetailController>(builder: (c) {
      bool relateField = c.dataModel.ifOriginArticle == 1;
      bool isPreSale = c.dataModel.isPresell == 1;

      return Container(
        color: KWhiteColor,
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 9.5.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: Row(
                children: [
                  BrnIconButton(
                    name: '看产地实景',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: relateField ? kAppColor : kAppSubGrey99Color),
                    direction: Direction.bottom,
                    iconHeight: 20.h,
                    iconWidth: 30.h,
                    iconWidget: Image.asset(
                      R.ASSETS_ICONS_TABS_FIELD_PNG,
                      color: relateField ? kAppColor : kAppSubGrey99Color,
                    ),
                    onTap: relateField ? c.onLookVR : null,
                  ),
                  BrnIconButton(
                    name: '购物车',
                    style:
                        TextStyle(fontSize: 14.sp, color: kAppSubGrey99Color),
                    direction: Direction.bottom,
                    iconHeight: 20.h,
                    iconWidth: 30.h,
                    iconWidget: Badge(
                      showBadge: c.goodsCountInCart > 0,
                      badgeContent: Text(
                        '${c.goodsCountInCart}',
                        style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
                      ),
                      child: Image.asset(R.ASSETS_ICONS_TABS_CART_PNG),
                    ),
                    onTap: c.onToCart,
                  ),
                ],
              ),
            ),
            Expanded(
              child: isPreSale
                  ? GestureDetector(
                      // onTap: c.dataModel.residueNum! > 0
                      //     ? c.takePartInPreSale
                      //     : null,
                      onTap: () {
                        if (c.dataModel.residueNum! > 0) {
                          Get.bottomSheet(_buildAddToCartBottomSheet(1));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: c.dataModel.residueNum! > 0
                              ? kAppColor
                              : kAppSubGrey99Color,
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                        child: Text('参与合买',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: KWhiteColor, fontSize: 15.sp)),
                      ),
                    )
                  : DefaultTextStyle(
                      style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(_buildAddToCartBottomSheet(0));
                            },
                            child: Container(
                              padding: EdgeInsets.all(14.w),
                              color: Colors.orange,
                              child: Text('加入购物车'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(_buildAddToCartBottomSheet(1));
                            },
                            child: Container(
                              padding: EdgeInsets.all(14.w),
                              color: kAppColor,
                              child: Text('立即购买'),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  // 0 加入购物车 1 立即购买
  Widget _buildAddToCartBottomSheet(int type) {
    return Container(
      height: Get.height / 2,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(14.w),
      ),
      child: GetBuilder<GoodsDetailController>(builder: (c) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Image.network(c.dataModel.goodsImage!,
                            width: 120.w, fit: BoxFit.cover),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: c.dataModel.goodsPrice,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: '  /箱',
                                  style: TextStyle(
                                    color: kAppSubGrey99Color,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('库存：${c.dataModel.inventory}件',
                              style: TextStyle(
                                  fontSize: 11.sp, color: kAppGrey66Color)),

                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: Get.back,
                  child: Image.asset(
                    R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                    width: 20.w,
                    fit: BoxFit.cover,
                    color: kAppSubGrey99Color,
                  ),
                ),
              ],
            ),
            //  配送地址
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '配送区域',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: kAppBlackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '(所选配送可能会影响库存, 请正确选择)',
                              style: TextStyle(
                                  fontSize: 11.sp, color: kAppGrey66Color),
                            )
                          ],
                        ),
                      ),
                      GetBuilder<FieldController>(
                        id: 'update_location',
                        builder: (_) {
                          return GestureDetector(
                            onTap: () => _.onSelectAddress(true),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16.w, color: kAppSubGrey99Color),
                                  Text(
                                    _.searchModel.mergename!.isNotEmpty
                                        ? _.searchModel.mergename!
                                        : '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: kAppSubGrey99Color),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // GestureDetector(
                      //   onTap: c.onSelectAddress,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 8.h),
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.location_on,
                      //             size: 16.w, color: kAppSubGrey99Color),
                      //         Text(
                      //           '${c.dataModel.mergename == '' ? c.fieldController.searchModel.mergename : c.dataModel.mergename}',
                      //           style: TextStyle(color: kAppGrey66Color),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 20.w,
                    color: kAppSubGrey99Color,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: '购买数量',
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: kAppBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                NumberItem(
                  number: c.buyCount,
                  isEnable: c.dataModel.inventory == '已售罄' ? false : true,
                  addClick: (value) {
                    c.buyCount = value;
                  },
                  subClick: (value) {
                    c.buyCount = value;
                  },
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                if (c.dataModel.inventory != '已售罄') {
                  type == 0 ? c.onAddToCart() : c.onBuyNow();
                } else {
                  showToast('${c.dataModel.inventory}');
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: kAppColor,
                  borderRadius: BorderRadius.circular(30.w),
                ),
                width: Get.width,
                child: Text(
                  '确定',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget get buildAppBar => SliverAppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 20.w,
          onPressed: () {
            Get.back();
          },
        ),
        pinned: true,
        title: const Text(''),
        centerTitle: true,
        actions: [
          GetBuilder<GoodsDetailController>(builder: (c) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => c.onMarkUnlike(c.dataModel),
                  child: Image.asset(
                          c.dataModel.goodsNotLike == 1
                              ? R.ASSETS_IMAGES_GOODS_DETAIL_UNLIKE_PNG
                              : R.ASSETS_ICONS_MARKET_GOODS_DETAIL_UNLIKE_SELECTED_PNG,
                          width: 22.w)
                      .paddingOnly(right: 6.w),
                ),
                // if (c.dataModel.ifMessageShow == 1)
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
                  child: Badge(
                    position: BadgePosition(top: 2.h, start: 14.w),
                    showBadge: c.dataModel.messageCount! > 0,
                    badgeContent: Text(
                      '${c.dataModel.messageCount}',
                      style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
                    ),
                    child: Image.asset(
                        R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                        width: 25.w),
                  ),
                ),
                // Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                //         width: 22.w)
                //     .paddingOnly(right: 6.w),
                GestureDetector(
                  onTap: () => c.onMarkLike(c.dataModel),
                  child: Image.asset(
                          c.dataModel.goodsLike == 1
                              ? R.ASSETS_IMAGES_GOODS_DETAIL_LIKE_PNG
                              : R.ASSETS_ICONS_MARKET_GOODS_DETAIL_LIKE_SELECTED_PNG,
                          width: 22.w)
                      .paddingOnly(right: 6.w),
                ),
                GestureDetector(
                  onTap: c.shareToSession,
                  child: Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG,
                          width: 22.w)
                      .paddingOnly(right: 6.w),
                ),
              ],
            );
          })
        ],
      );
}
