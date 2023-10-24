import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/models/advertisement_model.dart';

class AdPromotionView extends StatelessWidget {
  AdPromotionView({Key? key, required this.list}) : super(key: key);

  List<Advertisement> list = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (list.length > 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "promotion".tr,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          Column(
            children: list.map((val) {
              return InkWell(
                onTap: () {
                  print(val);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(val.img!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Widget promotion =
}
