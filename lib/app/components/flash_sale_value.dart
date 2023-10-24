import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mallxx_app/const/colors.dart';

// import 'package:mallxx/pages/product/productInfoPage.dart';

class FlashSaleView extends StatefulWidget {
  const FlashSaleView({Key? key}) : super(key: key);

  @override
  _FlashSaleState createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSaleView> {
  Widget _goodsItem() {
    return GestureDetector(
      onTap: () {
        print("click goods");
        // Get.to(
        //   () => ProductInfoPage(),
        //   transition: Transition.rightToLeft,
        //   arguments: {"id": 1},
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.all(5),
        width: 100,
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 110,
              child: Image.asset(
                "assets/images/bg1.png",
                fit: BoxFit.fill,
              ),

              // flex: 2,
            ),
            Text(
              "price".trArgs(["321.00"]),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            Text(
              "price".trArgs(["123.00"]),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          GestureDetector(
            onTap: () {
              print("Flash Sale");
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "flash_sale".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Text(
                        "end_in".tr,
                        style: const TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Text(
                          "0",
                          style: const TextStyle(
                            fontSize: 12,
                            color: KWhiteColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        child: const Text(
                          ":",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Text(
                          "0",
                          style: const TextStyle(
                            fontSize: 12,
                            color: KWhiteColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        child: const Text(
                          ":",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Text(
                          "34",
                          style: TextStyle(
                            fontSize: 12,
                            color: KWhiteColor,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_right,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
                _goodsItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
