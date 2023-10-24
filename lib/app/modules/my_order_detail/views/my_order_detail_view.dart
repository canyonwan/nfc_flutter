import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:timelines/timelines.dart';

import '../../../models/order_detail_model.dart';
import '../controllers/my_order_detail_controller.dart';

class MyOrderDetailView extends GetView<MyOrderDetailController> {
  const MyOrderDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('订单详情'), centerTitle: true),
      backgroundColor: kBgGreyColor,
      body: controller.obx(
        (state) => ListView(
          padding: EdgeInsets.all(12.w),
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${controller.data.zhuangtai}',
                style: TextStyle(color: kAppBlackColor, fontSize: 14.sp),
              ).paddingAll(10.w),
            ),
            _buildOrderAddress,
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: controller.data.goodsList!
                    .map((e) => _buildOrderProductItem(e))
                    .toList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 10.w),
              child: Column(
                children: [
                  ListTile(
                    title: Text('应付总额'),
                    trailing: Text('￥${controller.data.orderAmount}',
                        style: TextStyle(color: Colors.red)),
                  ),
                  ListTile(
                    title: Text('商品总价'),
                    trailing: Text('￥${controller.data.totalGoodsPrice}'),
                  ),
                  ListTile(
                    title: Text('代金券'),
                    trailing: Text('-￥${controller.data.voucherPrice}'),
                  ),
                  ListTile(
                    title: Text('运费'),
                    trailing: Text('+￥${controller.data.shipFee}'),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('订单编号'),
                    trailing: Text('${controller.data.orderSn}'),
                  ),
                  ListTile(
                    title: Text('支付方式'),
                    trailing: Text('${controller.data.paymentCode}'),
                  ),
                  ListTile(
                    title: Text('支付交易单号'),
                    trailing: Text('${controller.data.paymentNum}'),
                  ),
                  ListTile(
                    title: Text('下单时间'),
                    trailing: Text('${controller.data.createTime}'),
                  ),
                  ListTile(
                    title: Text('订单备注'),
                    trailing: Text('${controller.data.remark}'),
                  ),
                ],
              ),
            ),
            if (controller.data.orderTimeList!.isNotEmpty)
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 10.w),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Timeline.tileBuilder(
                  shrinkWrap: true,
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    // color: Color(0xffc2c5c9),
                    color: Colors.red,
                    connectorTheme: ConnectorThemeData(
                      thickness: 3.0,
                      color: Colors.redAccent,
                    ),
                  ),
                  padding: EdgeInsets.all(12.w),
                  builder: TimelineTileBuilder.connected(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.w),
                      child: Text(
                        '${controller.data.orderTimeList![index].acceptstation}',
                      ),
                    ),
                    connectorBuilder: (_, index, type) => Connector.solidLine(
                      color: kAppColor.withOpacity(.2),
                    ),
                    itemCount: controller.data.orderTimeList!.length,
                    indicatorBuilder: (_, int index) => DotIndicator(
                      size: 8.w,
                      color: kAppColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
        onLoading: BrnPageLoading(),
        onError: (e) => Center(child: Text('$e')),
      ),
    );
  }

  Widget _buildOrderProductItem(GoodsItemModel model) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.GOODS_DETAIL, arguments: model.goodsId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
            child: Row(
              children: [
                Image.network(
                  model.image!,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Text(model.goodsName!,
                        style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
                Column(
                  children: [
                    Text('￥${model.goodsPrice!}',
                        style: TextStyle(fontSize: 16.sp)),
                    SizedBox(height: 16.w),
                    Text('x${model.goodsNum!}',
                        style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildOrderAddress {
    AddressDetailModel address = controller.data.addressDetail!;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: kAppColor,
                  borderRadius: BorderRadius.circular(5.w),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${address.address!}', style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 4.h),
              Text('${address.addressName} ${address.addressPhone}',
                  style: TextStyle(fontSize: 13.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
