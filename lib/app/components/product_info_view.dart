import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';

import 'package:mallxx_app/app/modules/product_info/controllers/product_info_controller.dart';
import 'package:mallxx_app/const/colors.dart';

import '/app/components/photo_preview.dart';
import '/app/models/product_model.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({Key? key}) : super(key: key);
  @override
  _ProductInfoViewState createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  double statusHeight = MediaQueryData.fromWindow(window).padding.top;
  final ProductInfoController productInfoController =
      Get.find<ProductInfoController>();
  @override
  Widget build(BuildContext context) {
    Product? _item = productInfoController.productInfo.value;
    List<String> _images = [];
    if (_item.albumPics != null && _item.albumPics! != "") {
      _images = _item.albumPics!.split(",");
    }

// print(_images.length);
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width,
                // color: KWhiteColor,
                child: Swiper(
                  key: UniqueKey(),
                  itemCount: _images.length,
                  loop: _images.length == 1 ? false : true,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => PhotoPreView(index: index, images: _images),
                          transition: Transition.fadeIn,
                          fullscreenDialog: true,
                        );
                      },
                      child: Image.network(
                        _images[index],
                        fit: BoxFit.fitWidth,
                        // loadingBuilder: (context, child, loadingProgress) {
                        //   return loadingProgress == null
                        //       ? child
                        //       : LinearProgressIndicator();
                        // },
                      ),
                    );
                  },
                  pagination: const SwiperPagination(
                    builder: SwiperPagination.dots,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.only(
                      left: 12, right: 48, top: 40, bottom: 20),
                  child: Container(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Image.asset(
                      "assets/icons/back_status.png",
                      width: 30,
                      height: 30,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: const ShapeDecoration(
                  color: KWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      _item.subTitle ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "price".trArgs(
                          ["${productInfoController.defaultPrice.value}", ""]),
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
