import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/components/number_item.dart';
import 'package:mallxx_app/app/models/cart_list_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import '../controllers/shop_cart_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class ShopCartView extends GetView<ShopCartController> {
  @override
  Widget build(BuildContext context) {
    controller.getCarts();
    return Scaffold(
        appBar: _buildAppbar,
        body: controller.obx(
            (state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          // 24小时内送达
                          _buildToday,
                          // 24小时内发货
                          _buildTodaySend,
                          // 无法送达
                          _buildCantSend,
                          // 已售罄/已下架
                          _buildInvalid,
                        ],
                      ),
                    ),
                    _buildBottomTotal
                  ],
                ),
            onError: (value) => GestureDetector(
                  onTap: controller.getCarts,
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
                        '$value' + ',点击重试',
                        style: TextStyle(color: KWhiteColor, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
            onLoading: BrnPageLoading(),
            onEmpty: BrnAbnormalStateWidget(
              isCenterVertical: true,
              title: BrnStrings.noData,
            )));
  }

  // 底部结
  Container get _buildBottomTotal {
    return Container(
      width: Get.width,
      color: KWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 全选按钮
            _buildCheckAll,
            controller.isEdit.isTrue
                ? _buildBottomBar
                : Expanded(child: _buildBottomBar)
          ],
        ),
      ),
    );
  }

  Widget get _buildBottomBar {
    return AnimatedCrossFade(
      firstChild: _buildTotalRow,
      secondChild: _buildBottomDelete,
      crossFadeState: controller.isEdit.isFalse
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 250),
    );
  }

  Widget get _buildBottomDelete {
    return GestureDetector(
      onTap: () {
        controller.checkedCartIds.isNotEmpty
            ? Get.defaultDialog(
                titlePadding: EdgeInsets.only(
                  top: 15.h,
                  bottom: 15.h,
                ),
                content: _buildDelDialog,
                title: "确认要删除这${controller.checkedCartIds.length}种商品吗？",
                titleStyle: TextStyle(
                  color: kAppGrey66Color,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
                radius: 10.w,
              )
            : null;
      },
      child: Container(
        width: 140.w,
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 10.h,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: controller.checkedCartIds.isNotEmpty
              ? kAppColor
              : kAppSubGrey99Color,
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Text(
            'delete'.tr +
                '(${controller.checkedCartIds.length > 99 ? '99+' : controller.checkedCartIds.length})',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: KWhiteColor)),
      ),
    );
  }

  Widget get _buildDelDialog {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 34.w),
      // padding: EdgeInsets.symmetric(horizontal: 36.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: Get.back,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(40.w),
                    border: Border.all(width: 1, color: kAppColor),
                  ),
                  child: Text('取消',
                      style: TextStyle(color: kAppColor, fontSize: 14.sp)),
                ),
              ),
              SizedBox(width: 30.w),
              GestureDetector(
                onTap: controller.delCartGoods,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: kAppColor,
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  child: Text('确定',
                      style: TextStyle(color: KWhiteColor, fontSize: 14.sp)),
                ),
              ),
            ],
          ).paddingOnly(top: 30.w),
        ],
      ),
    );
  }

  Widget get _buildTotalRow {
    return Row(
      children: [
        GetBuilder<ShopCartController>(
            id: 'update_calc_price',
            builder: (c) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '总计：', style: TextStyle(fontSize: 12.sp)),
                          TextSpan(
                              text:
                                  '￥${c.calcCartTotalPriceDataModel?.goodsPrice ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                    Text(
                      '运费：￥${c.calcCartTotalPriceDataModel?.freight ?? '0.00'}',
                      style:
                          TextStyle(fontSize: 12.sp, color: kAppSubGrey99Color),
                    ),
                  ],
                ),
              );
            }),
        Expanded(
          child: GestureDetector(
            onTap: controller.onToOrderConfirm,
            child: Container(
              width: 140.w,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.checkedCartIds.isNotEmpty
                    ? kAppColor
                    : kAppSubGrey99Color,
                borderRadius: BorderRadius.circular(30.w),
              ),
              child: Text(
                '结算(${controller.checkedCartIds.length > 99 ? '99+' : controller.checkedCartIds.length})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row get _buildCheckAll {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Obx(
            () => Checkbox(
              tristate: true,
              shape: const CircleBorder(),
              activeColor: kAppColor,
              checkColor: KWhiteColor,
              hoverColor: KWhiteColor,
              focusColor: kAppColor,
              side: const BorderSide(color: kAppGrey66Color),
              value: controller.isAllCheck.value,
              onChanged: (value) {
                controller.onIsAllCheck();
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            "cart_choice".tr,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // 已售罄/已下架
  Obx get _buildInvalid {
    return Obx(() {
      return controller.invalid.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 12.h),
              shrinkWrap: true,
              itemCount: controller.invalid.length,
              itemBuilder: (_, int index) {
                return _buildItem(controller.invalid[index], index, '已售罄/已下架');
              },
            )
          : SizedBox();
    });
  }

  // 无法送达
  Obx get _buildCantSend {
    return Obx(() {
      return controller.notSend.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 12.h),
              shrinkWrap: true,
              itemCount: controller.notSend.length,
              itemBuilder: (_, int index) {
                return _buildItem(controller.notSend[index], index, '无法送达');
              },
            )
          : SizedBox();
    });
  }

  // 48小时内发货
  Obx get _buildTodaySend {
    return Obx(() {
      return controller.todaySend.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 12.h),
              shrinkWrap: true,
              itemCount: controller.todaySend.length,
              itemBuilder: (_, int index) {
                return _buildItem(
                    controller.todaySend[index], index, '48小时内发货');
              },
            )
          : SizedBox();
    });
  }

  // 24小时内送达
  Obx get _buildToday {
    return Obx(() {
      return controller.today.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.5.w, vertical: 12.h),
              shrinkWrap: true,
              itemCount: controller.today.length,
              itemBuilder: (_, int index) {
                return _buildItem(controller.today[index], index, '24小时内送达');
              },
            )
          : SizedBox();
    });
  }

  Widget _buildItem(CartGoodsModel item, int index, String typeName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index == 0)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(typeName, style: TextStyle(fontSize: 14.sp)),
          ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.5.h),
          decoration: BoxDecoration(
              color: KWhiteColor, borderRadius: BorderRadius.circular(8.w)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 10.w),
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: GetBuilder<ShopCartController>(
                      id: 'update_cart_Item',
                      builder: (context) {
                        return Checkbox(
                          tristate: true,
                          shape: const CircleBorder(),
                          activeColor: kAppColor,
                          checkColor: KWhiteColor,
                          hoverColor: KWhiteColor,
                          focusColor: kAppColor,
                          side: const BorderSide(color: kAppGrey66Color),
                          value: item.check!,
                          onChanged: (bool? value) =>
                              controller.onItemChecked(item, value ?? false),
                        );
                      }),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                //   child: Image.network(item.goodsImage!,
                //       width: 115.w, height: 115.w, fit: BoxFit.cover),
                // ),
                GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.GOODS_DETAIL, arguments: item.goodsId),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5.w)),
                    child: Image(
                      image: NetworkImage(item.goodsImage!),
                      width: 115.w,
                      height: 115.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.goodsName!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: kAppBlackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.goodsNum!,
                                style: TextStyle(
                                    fontSize: 13.sp, color: kAppGrey66Color),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(
                              text: '¥',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.sp),
                              children: [
                                TextSpan(
                                  text: item.goodsPrice,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18.sp),
                                ),
                              ],
                            )),
                            NumberItem(
                              number: double.parse(item.goodsNum!).toInt(),
                              isEnable: true,
                              addClick: (value) {
                                controller.onChangeCartQuantity(item, value);
                              },
                              subClick: (value) {
                                controller.onChangeCartQuantity(item, value);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget get _buildAppbar {
    return BrnAppBar(
      backgroundColor: kAppColor,
      automaticallyImplyLeading: true,
      brightness: Brightness.dark,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<FieldController>(
              id: 'update_location',
              builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: GestureDetector(
                    onTap: controller.onChangeAddress,
                    child: Row(
                      children: [
                        //Icon(Icons.location_on_rounded).paddingOnly(right: 6.w),
                        Image.asset(R.ASSETS_ICONS_FIELD_LOCATION_ICON_AT_2X_PNG,width: 16.w,),
                        SizedBox(width: 4.w),
                        SizedBox(
                          width: 140.w,
                          child: Text(
                            _.searchModel.mergename!.split(",").last,
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
                  ),
                );
              }),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: GetBuilder<ShopCartController>(
                  id: 'update_goods_count',
                  builder: (c) {
                    String str = '';
                    if (c.cartCountsData == null) {
                      str = '加载中..';
                    } else if (c.cartCountsData!.cardNumber > 99) {
                      str = '99+';
                    } else {
                      str = c.cartCountsData!.cardNumber.toString();
                    }
                    return Text(
                      'cart'.tr + ' ${str}',
                      style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                    );
                  },
                ),
              ),
              Obx(
                () => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.isEdit.toggle();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      controller.isEdit.isFalse ? "edit".tr : "finish".tr,
                      style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.MESSAGE_CENTER),
                child: Image.asset(R.ASSETS_ICONS_FIELD_MESSAGE_ICON_AT_2X_PNG,
                        width: 25.w)
                    .paddingOnly(right: 10.w),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
