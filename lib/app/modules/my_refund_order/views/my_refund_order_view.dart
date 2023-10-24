import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/my_order_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/my_refund_order_controller.dart';

class MyRefundOrderView extends GetView<MyRefundOrderController> {
  const MyRefundOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('售后/退款'), centerTitle: true),
      body: EasyRefresh.builder(
        controller: controller.easyRefreshController,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (_, physics) {
          return GetBuilder<MyRefundOrderController>(builder: (c) {
            return CustomScrollView(
              physics: physics,
              slivers: [
                c.orderList.isNotEmpty
                    ? buildSliverList(c.orderList)
                    : SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(top: 200.w),
                          alignment: Alignment.center,
                          child: Text('暂无数据'),
                        ),
                      ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget buildSliverList(List<OrderItemModel> orderList) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => buildOrderItem(orderList[index]),
          childCount: orderList.length,
        ),
      );

  Widget buildOrderItem(OrderItemModel m) => GestureDetector(
        onTap: () => controller.onToOrderView(m.id!, m.orderState!),
        child: Container(
          margin: EdgeInsets.all(10.w),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: KWhiteColor,
            borderRadius: BorderRadius.circular(7.w),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '下单时间：${m.createTime}',
                    style:
                        TextStyle(fontSize: 13.sp, color: kAppSubGrey99Color),
                  ),
                  Text(
                    '${m.zhuangtai}',
                    style: TextStyle(fontSize: 13.sp, color: kAppColor),
                  ),
                ],
              ).paddingOnly(bottom: 10.h),
              Row(
                children: [
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       ...List.generate(
                  //         m.goodsList!.length,
                  //         (index) => Image.network(m.goodsList![index].image!,
                  //             width: 86.w, height: 86.w),
                  //       ),
                  //       if (m.goodsList!.length == 1)
                  //         Expanded(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 '${m.goodsList![0].goodsName!}',
                  //                 maxLines: 2,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: TextStyle(
                  //                     fontSize: 16.sp,
                  //                     fontWeight: FontWeight.bold),
                  //               ).paddingSymmetric(
                  //                   horizontal: 10.w, vertical: 4.w),
                  //               if (m.goodsList![0].isEvaluate == 1)
                  //                 _buildButton(
                  //                     borderColor: kAppColor,
                  //                     label: '去评价',
                  //                     onTap: () => controller.onToAppraise(
                  //                         m.id!, m.goo)),
                  //             ],
                  //           ),
                  //         ),
                  //       if (m.goodsList!.length > 1) Container()
                  //     ],
                  //   ),
                  // ),

                  Expanded(
                    child: SizedBox(
                      height: 70.w,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...m.goodsList!
                              .map(
                                (e) => Container(
                                  child: Row(
                                    children: [
                                      Image.network(e.image!,
                                          width: 86.w, height: 86.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${e.goodsName!}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          ).paddingSymmetric(
                                              horizontal: 10.w, vertical: 4.w),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                  ),

                  /// 价格
                  Column(
                    children: [
                      Text.rich(TextSpan(
                          text: '¥',
                          style: TextStyle(fontSize: 11.sp),
                          children: [
                            TextSpan(
                              text: '${m.orderAmount}',
                              style: TextStyle(
                                  fontSize: 18.sp, color: kAppBlackColor),
                            ),
                          ])),
                      Text(
                        '共${m.totalGoodsNum}件商品',
                        style: TextStyle(
                            fontSize: 11.sp, color: kAppSubGrey99Color),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  GestureDetector _buildButton(
      {required String label,
      required VoidCallback onTap,
      Color? borderColor}) {
    return GestureDetector(
      // onTap: controller.onCancelOrder,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7.5.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(width: 1, color: borderColor ?? kBgGreyColor),
        ),
        child: Text('${label}',
            style: TextStyle(fontSize: 12.sp, color: borderColor)),
      ),
    );
  }
}
