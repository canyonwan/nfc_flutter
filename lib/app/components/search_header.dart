import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => const CategoryPage());
      },
      child: Container(
        width: double.infinity,
        height: 40,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        // height: 10,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.search,
                size: 20,
                color: Colors.black87,
              ),
            ),
            Text(
              "search".tr,
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
