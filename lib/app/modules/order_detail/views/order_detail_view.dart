import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mallxx_app/app/components/order_address_view.dart';
import 'package:mallxx_app/app/components/order_product_view.dart';
import 'package:mallxx_app/app/models/address_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  Widget _bottom() {
    return Container(
      color: KWhiteColor,
      alignment: Alignment.topRight,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "合计:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: "price".trArgs(["123"]),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print("canel");
                  // controller.onCheckout();
                  // Get.toNamed(Routes.ORDER_DETAIL);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: KWhiteColor,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "取消".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print("confirm");
                  // controller.onCheckout();
                  Get.toNamed(Routes.ORDER_SUCCESS);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Text(
                    "pay".tr,
                    style: const TextStyle(
                      color: KWhiteColor,
                      fontSize: 20,
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

  Widget _orderDetailItem(BuildContext context,
      {required String title, required Widget desc}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          desc,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('order_detail'.tr),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Obx(
            () => Container(
              alignment: Alignment.center,
              // height: 20,
              child: Text(controller.appBarStatusText.value),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              OrderAddressView(
                onTab: () {},
                isChange: false,
                address: MyAddressItem(),
              ),
              OrderProductView(
                list: [],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: KWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "订单信息",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      removeTop: true,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _orderDetailItem(
                            context,
                            title: "商品总价",
                            desc: Text(
                              "price".trArgs(["100"]),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "运费",
                            desc: Text(
                              "price".trArgs(["100"]),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "实付款",
                            desc: Text(
                              "price".trArgs(["100"]),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "积分抵扣",
                            desc: Text(
                              "price".trArgs(["100"]),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "订单号",
                            desc: Text(
                              "3423809840938609836",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "创建时间",
                            desc: Text(
                              "2022-02-10 12:11：23",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "付款时间",
                            desc: Text(
                              "2022-02-10 12:11：23",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "发货时间",
                            desc: Text(
                              "2022-02-10 12:11：23",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          _orderDetailItem(
                            context,
                            title: "成交时间",
                            desc: Text(
                              "2022-02-10 12:11：23",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
          Positioned(
            bottom: 0.0,
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: _bottom(),
          ),
        ],
      ),
    );
  }
}
