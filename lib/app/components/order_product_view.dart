import 'package:flutter/material.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:mallxx_app/const/colors.dart';

import '/app/models/order_confirm_model.dart';

class OrderProductView extends StatelessWidget {
  // final Li>
  final List<OrderFirmProduct> list;
  const OrderProductView({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "商品信息",
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
            child: ListView.builder(
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                OrderFirmProduct item = list[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            item.productPic!,
                            width: 81,
                            height: 66,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName!,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                item.attr ?? "",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              Text(
                                "price".trArgs(["${item.price!}"]),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "x${item.quantity!}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
