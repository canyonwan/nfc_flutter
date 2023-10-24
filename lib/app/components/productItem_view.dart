import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/product_model.dart';
import '/app/routes/app_pages.dart';

// import 'package:mallxx/pages/product/productInfoPage.dart';

class ProductItemView extends StatefulWidget {
  const ProductItemView({Key? key, required this.item}) : super(key: key);
  final Product item;
  @override
  _ProductItemViewState createState() => _ProductItemViewState();
}

class _ProductItemViewState extends State<ProductItemView> {
  @override
  Widget build(BuildContext context) {
    final Product item = widget.item;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Image.network(
              item.pic!,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Get.toNamed(
                Routes.PRODUCT_INFO,
                arguments: {"id": item.id!},
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            // height: 10,
            child: Text(
              item.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              item.subTitle!,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "price".trArgs(["${item.price}"]),
              //"US\$${item.price}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
