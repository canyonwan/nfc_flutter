import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:timelines/timelines.dart';

import '../../../models/order_detail_model.dart';
import '../controllers/my_refund_order_detail_controller.dart';

class MyRefundOrderDetailView extends GetView<MyRefundOrderDetailController> {
  const MyRefundOrderDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('退款详情'), centerTitle: true),
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
            Container(
              margin: EdgeInsets.only(top: 10.w),
              padding: EdgeInsets.all(10.w),
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
                    title: Text('退款总额'),
                    trailing: Text('￥${controller.data.returnPrice}',
                        style: TextStyle(color: Colors.red)),
                  ),
                  ListTile(
                    title: Text('退款余额'),
                    trailing: Text('￥${controller.data.shouldReturnPrice}'),
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
                    title: Text('退款编号'),
                    trailing: Text('${controller.data.orderSn}'),
                  ),
                  ListTile(
                    title: Text('退款金额'),
                    trailing: Text('${controller.data.returnPrice}'),
                  ),
                  ListTile(
                    title: Text('申请时间'),
                    trailing: Text('${controller.data.refundTime}'),
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
                margin: EdgeInsets.symmetric(vertical: 10.w),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Timeline.tileBuilder(
                    shrinkWrap: true,
                    builder: TimelineTileBuilder.fromStyle(
                      contentsAlign: ContentsAlign.alternating,
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                            '${controller.data.orderTimeList![index].acceptstation}'),
                      ),
                      itemCount: controller.data.orderTimeList!.length,
                    )),
              ),
          ],
        ),
        onLoading: BrnPageLoading(),
        onError: (e) => Center(child: Text('$e')),
      ),
    );
  }

  Widget _buildOrderProductItem(GoodsItemModel model) {
    return Column(
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
                  child:
                      Text(model.goodsName!, style: TextStyle(fontSize: 16.sp)),
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
    );
  }
}
