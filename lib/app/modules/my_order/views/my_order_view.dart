import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/models/my_order_model.dart';
import 'package:mallxx_app/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:mallxx_app/const/colors.dart';

class MyOrderView extends GetView<MyOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单列表'),
        centerTitle: true,
        bottom: _buildTabs,
      ),
      body: EasyRefresh.builder(
        controller: controller.easyRefreshController,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoadMore,
        childBuilder: (_, physics) {
          return GetBuilder<MyOrderController>(builder: (c) {
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
                                          if (e.isEvaluate == 1)
                                            _buildButton(
                                              borderColor: kAppColor,
                                              label: '去评价',
                                              onTap: () =>
                                                  controller.onToAppraise(m.id!,
                                                      e.goodsId!, e.image!),
                                            ),
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

              /// 按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (m.isCancel == 1)
                    _buildButton(
                        label: '取消订单',
                        onTap: () {
                          Get.dialog(orderRefundAlert(
                            paymentCode: m.paymentNum!,
                            title: '取消订单',
                            onTap: () =>
                                controller.onCancelOrder(m.paymentNum!),
                          ));
                        }),
                  if (m.isPay == 1)
                    _buildButton(
                        label: '去付款', onTap: () => controller.onToPayment(m)),
                  if (m.isRefund == 1)
                    _buildButton(
                        label: '申请退款',
                        onTap: () {
                          Get.dialog(orderRefundAlert(
                            paymentCode: m.paymentNum!,
                            showInput: true,
                            title: '申请退款',
                            onTap: () =>
                                controller.onApplyForRefund(m.paymentNum!),
                          ));
                        }),
                  if (m.isLogistics == 1)
                    _buildButton(
                        label: '查看物流',
                        onTap: () =>
                            controller.showLogistics(m.id!, m.orderState!)),
                  if (m.isReceipt == 1)
                    _buildButton(
                        label: '确认收货',
                        onTap: () => controller.confirmGoods(m.id!)),
                  if (m.isDelete == 1)
                    _buildButton(
                        label: '删除订单',
                        onTap: () => controller.deleteOrder(m.id!)),
                  if (m.isDetail == 1)
                    _buildButton(
                        label: '查看订单',
                        onTap: () =>
                            controller.showOrder(m.id!, m.orderState!)),
                  // _buildButton(
                  //     borderColor: kAppColor,
                  //     label: '去评价',
                  //     onTap: () => controller.onToAppraise(m.id!)),
                ],
              ),
            ],
          ),
        ),
      );

  // 申请退款
  Widget orderRefundAlert(
      {required String paymentCode,
      required String title,
      required VoidCallback onTap,
      showInput = false}) {
    return GFAlert(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      title: title,
      type: GFAlertType.rounded,
      contentChild: showInput
          ? TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              onChanged: (value) => controller.onReasonChanged(value),
              decoration: InputDecoration(
                hintText: "请输入退款原因",
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
              ),
            )
          : null,
      bottombar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GFButton(
            onPressed: Get.back,
            color: KWhiteColor,
            borderSide: BorderSide(color: kAppColor),
            child: const Text('取消', style: TextStyle(color: kAppColor)),
          ),
          GFButton(
            // onPressed: () => controller.onApplyForRefund(paymentCode),
            onPressed: onTap,
            color: kAppColor,
            child: const Text('确定', style: TextStyle(color: KWhiteColor)),
          ),
        ],
      ),
    );
  }

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

  PreferredSize get _buildTabs {
    return PreferredSize(
      preferredSize: Size(Get.width, 40.h),
      child: Container(
        width: Get.width,
        color: KWhiteColor,
        child: BrnSwitchTitle(
          controller: controller.tabController,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
          nameList: controller.tabs,
          defaultSelectIndex: 0,
          selectedTextStyle: TextStyle(color: kAppColor, fontSize: 16.sp),
          unselectedTextStyle:
              TextStyle(color: kAppSubGrey99Color, fontSize: 16.sp),
          onSelect: (value) => controller.onSelect(value),
        ),
      ),
    );
  }
}
