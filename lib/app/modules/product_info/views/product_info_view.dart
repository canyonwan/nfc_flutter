import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/product_info/controllers/product_info_controller.dart';
import 'package:mallxx_app/const/colors.dart';

import '/app/components/product_info_view.dart' as PinfoView;
import '../components/attribute_view.dart';
import '../components/comment_view.dart';
import '../components/service_description_view.dart';
import '../components/sku_specification_view.dart';

class ProductInfoView extends GetView<ProductInfoController> {
  // late model.Product? _product = model.Product();

  Widget _bottomBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  print("contact our");
                },
                child: Text("contact_our".tr),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  if (!controller.onAddCart()) {
                    _showSpec(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffff9b00),
                        Color(0xffF8CD6A),
                      ],
                    ),
                  ),
                  child: Text(
                    "add_cart".tr,
                    style: const TextStyle(color: KWhiteColor),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  if (!controller.onBuyNow()) {
                    _showSpec(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFF5252),
                        Color(0xffFF0000),
                      ],
                    ),
                  ),
                  child: Text(
                    "buy_now".tr,
                    style: const TextStyle(color: KWhiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    double scale = MediaQuery.of(context).devicePixelRatio;
    return AppBar(
      backgroundColor: Colors.red,
      leading: Platform.isIOS
          ? GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: scale > 2 ? 0 : 10),
                child: Image.asset(
                  "assets/icons/back_status.png",
                ),
              ),
              onTap: () {
                Get.back();
              },
            )
          : IconButton(
              padding: EdgeInsets.symmetric(vertical: scale > 3.0 ? 0 : 10),
              icon: Image.asset("assets/icons/back_status.png"),
              onPressed: () {
                Get.back();
              },
            ),
      title: TabBar(
        isScrollable: true,
        indicatorColor: KWhiteColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: const EdgeInsets.all(10),
        tabs: controller.tabs,
        indicatorWeight: 3,
        labelColor: KWhiteColor,
        controller: controller.tabController,
        onTap: (index) {
          if (controller.tabController.indexIsChanging) {
            switch (index) {
              case 0:
                controller.tabController.animateTo(0);
                controller.scrollController.jumpTo(0);
                break;
              case 1:
                controller.tabController.animateTo(1);
                controller.scrollController.jumpTo(controller.goodsHeight);
                break;
              case 2:
                controller.tabController.animateTo(2);
                controller.scrollController
                    .jumpTo(controller.goodsDescHeight + 2);
                break;
            }
          }
        },
      ),
      centerTitle: true,
    );
  }

  List<Widget> _serverList() {
    String? serviceIds = controller.productInfo.value.serviceIds;
    List<Widget> _servicesView = [];
    if (serviceIds != null) {
      List<String> servicesIds = serviceIds.split(",");
      for (int i = 0; i < servicesIds.length; i++) {
        String val = servicesIds[i];
        if (val.isEmpty) {
          break;
        }

        _servicesView.add(Image.asset("assets/icons/dots.png"));
        if (val == "1") {
          _servicesView.add(Text("free_return".tr));
        }
        if (val == "2") {
          _servicesView.add(Text("quick_refund".tr));
        }

        if (val == "3") {
          _servicesView.add(Text("free_shipping".tr));
        }
        _servicesView.add(SizedBox(
          width: val == "3" ? 10 : 5,
        ));
      }
    }
    _servicesView.add(Image.asset(
      "assets/icons/arrow_right.png",
      width: 12,
      height: 12,
      color: Colors.grey,
    ));

    return _servicesView;
  }

  void _showSpec(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      context: context,
      builder: (context) {
        // return Container();
        return SkuSpecificationView(
          initSkut: controller.defaultSku.value,
          skuStock: controller.productInfo.value.skuStock,
          productAttrValue: controller.productInfo.value.productAttrValue,
          productAttribute: controller.productInfo.value.productAttribute,
          onClickItem: (sku, txt) {
            controller.setDefaultSku(sku);
            controller.selectSpecText.value = txt;
          },
          onclickFinish: (sku, count) {
            if (sku != null) {
              controller.defaultSku.value = sku;
            }

            controller.buyCount.value = count;
            controller.onFinish();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.isFalse
          ? Scaffold(
              bottomNavigationBar: _bottomBar(context),
              backgroundColor: Colors.grey[200],
              body: Stack(
                children: [
                  SingleChildScrollView(
                    // key: UniqueKey(),
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 500,
                          key: controller.goodsKey,
                          child: PinfoView.ProductInfoView(),
                        ),

                        ///商品描述
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          decoration: const ShapeDecoration(
                            color: KWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 8),
                            decoration: const ShapeDecoration(
                              color: Colors.white60,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      ServiceDescriptionView(),
                                      backgroundColor: KWhiteColor,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "service_description".tr,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Row(
                                        children: _serverList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 0.2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    //attribue
                                    Get.bottomSheet(
                                      AttributeView(
                                        list: controller
                                                .productInfo.value.parameters ??
                                            [],
                                      ),
                                      backgroundColor: KWhiteColor,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("product_parameters".tr,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      Row(
                                        children: [
                                          Text("date_brand".tr),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/icons/arrow_right.png",
                                            width: 12,
                                            height: 12,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 0.2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showSpec(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("select_specifications".tr,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      Row(
                                        children: [
                                          Text(controller.selectSpecText.value),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/icons/arrow_right.png",
                                            width: 12,
                                            height: 12,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const CommentView(),
                        Column(
                          children: [
                            Text(
                              "product_detail".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              // padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: KWhiteColor,
                              ),
                              // height: 100,
                              width: double.infinity,
                              // child: parse(controller.productInfo.value.detailMobileHtml ?? ''),
                              child: HtmlWidget(
                                controller.productInfo.value.detailMobileHtml ??
                                    "",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: controller.toolbarOpacity.value,
                    child: Container(
                      height: 78,
                      color: Colors.red,
                      child: _topBar(context),
                    ),
                  )
                ],
              ),
            )
          : Container(
              color: KWhiteColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
  }
}
