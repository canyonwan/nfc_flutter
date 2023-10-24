import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/address_model.dart';
import 'package:mallxx_app/app/models/cart_create_order_model.dart';
import 'package:mallxx_app/app/models/cart_list_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '/app/components/order_address_view.dart';
import '../controllers/order_confirm_controller.dart';

class OrderConfirmView extends GetView<OrderConfirmController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgGreyColor,
      appBar: AppBar(title: Text('order_confirm'.tr), centerTitle: true),
      body: controller.obx(
        (state) => _buildBody,
        onLoading: Center(child: BrnPageLoading()),
        onError: (e) => Center(child: Text('$e')),
      ),
    );
  }

  Widget get _buildBody {
    CartCreateOrderDataModel data = controller.cartCreateOrderData!;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              //Address
              // if (data.ifShowAddress == 1) _buildOrderAddress,
              _buildOrderAddress,
              //商品
              if (data.today!.isNotEmpty)
                _buildOrderProducts(data.today!, '当日送达', data.todayTime!),
              if (data.todaySend!.isNotEmpty)
                _buildOrderProducts(
                    data.todaySend!, '48小时内发货', data.todaySendTime!),
              if (data.notSend!.isNotEmpty)
                _buildOrderProducts(data.notSend!, '无法送达', data.notSendTime!),
              if (data.invalid!.isNotEmpty)
                _buildOrderProducts(data.invalid!, '其他原因', data.invalidTime!),
              // OrderProductView(list: controller.buyProductList),
              // OrderProductView(list: controller.cartCreateOrderData.today!),

              //优惠券
              _buildCoupon,

              // 最后的总结栏
              _buildSummaryBox,
            ],
          ),
        ),
        _buildBottomTotal(),
      ],
    );
  }

  OrderAddressView get buildOrderAddressView {
    return OrderAddressView(
      onTab: () {
        controller.onAddress();
      },
      isChange: true,
      // address: controller.defaultAddress.value,
      address: controller.cartCreateOrderData!.showAddress!,
    );
  }

  Widget get _buildOrderAddress {
    MyAddressItem address = controller.defaultAddress;
    return GestureDetector(
      onTap: controller.onAddress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
        color: KWhiteColor,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                    color: kAppColor,
                    borderRadius: BorderRadius.circular(40.w),
                  ),
                  child: Text('默认',
                      style: TextStyle(color: KWhiteColor, fontSize: 10.sp)),
                ),
                Text('${address.province} ${address.city} ${address.county}',
                        style: TextStyle(fontSize: 12.sp))
                    .paddingOnly(left: 10.w),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${address.address!}',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: 4.h),
                    Text('${address.addressName} ${address.addressPhone}',
                        style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right_outlined,
                    color: kAppSubGrey99Color, size: 24.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderProducts(
      List<CartGoodsModel> list, String name, String time) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      color: KWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
            child: Row(
              children: [
                Image.asset(R.ASSETS_ICONS_TABS_MARKET_PNG,
                    width: 20.w, height: 20.w, fit: BoxFit.cover),
                SizedBox(width: 10.w),
                Text(name, style: TextStyle(fontSize: 18.sp)),
              ],
            ),
          ),
          Divider(),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: list.map((e) => _buildOrderProductItem(e, name)).toList(),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
            child: Text('预计送达时间：$time', style: TextStyle(fontSize: 14.sp)),
          )
        ],
      ),
    );
  }

  Widget _buildOrderProductItem(CartGoodsModel model, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
          child: Row(
            children: [
              ['无法送达', '其他原因'].contains(name)
                  ? ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(kAppSubGrey99Color, BlendMode.color),
                      child: Image.network(
                        model.goodsImage!,
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.network(
                      model.goodsImage!,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.goodsName!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ['无法送达', '其他原因'].contains(name)
                                  ? kAppSubGrey99Color
                                  : null)),
                      SizedBox(height: 16.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(model.goodsPrice!,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ['无法送达', '其他原因'].contains(name)
                                      ? kAppSubGrey99Color
                                      : null)),
                          Text('x${model.goodsNum!}',
                              style: TextStyle(
                                  fontSize: 14.sp, color: kAppSubGrey99Color)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomTotal() {
    return Container(
      color: KWhiteColor,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "￥",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      // text: "price".trArgs(["123"]),
                      text: '${controller.cartCreateOrderData!.totalPrice!}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.onConfirmPay,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 42.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w),
                    color: kAppColor,
                  ),
                  child: Text(
                    "pay".tr,
                    style: TextStyle(
                      color: KWhiteColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildCoupon {
    return Container(
      color: KWhiteColor,
      child: ListTile(
        onTap: controller.onCoupon,
        title: Text(
          '代金券',
          style: TextStyle(fontSize: 12.sp),
        ),
        trailing: GestureDetector(
          child: Container(
            alignment: Alignment.centerRight,
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('-￥${controller.cartCreateOrderData!.voucherPrice}'),
                Icon(Icons.keyboard_arrow_right_outlined, size: 18.w)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container get _buildSummaryBox {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              '商品金额',
              style: TextStyle(fontSize: 12.sp),
            ),
            trailing: GestureDetector(
              onTap: () {
                controller.onCoupon();
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('￥${controller.cartCreateOrderData!.goodsPrice}'),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              '商品代金券',
              style: TextStyle(fontSize: 12.sp),
            ),
            trailing: GestureDetector(
              onTap: () {
                controller.onCoupon();
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('-￥${controller.cartCreateOrderData!.voucherPrice}',
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ),
          if (controller.cartCreateOrderData!.isVip == 1)
            ListTile(
              title: Text(
                '优源专享卡',
                style: TextStyle(fontSize: 12.sp),
              ),
              trailing: GestureDetector(
                onTap: () {
                  controller.onCoupon();
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  width: 250.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('-￥${controller.cartCreateOrderData!.specialPrice}',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ),
          if (controller.cartCreateOrderData!.isVip == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${controller.cartCreateOrderData!.specialPrice}',
                    style: TextStyle(color: Colors.red)),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.MY_VIP),
                  child: Text('去开通', style: TextStyle(color: kAppColor)),
                ),
              ],
            ).paddingSymmetric(horizontal: 14.w),
          ListTile(
            title: Text(
              '运费',
              style: TextStyle(fontSize: 12.sp),
            ),
            trailing: GestureDetector(
              onTap: () {
                controller.onCoupon();
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('+￥${controller.cartCreateOrderData!.totalFee}'),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text(
                  '备注：',
                  style: TextStyle(fontSize: 12.sp),
                ).marginOnly(right: 4.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '点击留言',
                      hintStyle: TextStyle(fontSize: 10.sp),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (String value) =>
                        controller.onRemarkChange(value),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
