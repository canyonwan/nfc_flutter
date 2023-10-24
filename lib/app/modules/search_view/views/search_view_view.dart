import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_view_controller.dart';

///
class SearchViewView extends GetView<SearchViewController> {
  const SearchViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnSearchAppbar(
        controller: controller.textController,
        leading: BackButton(),
        searchBarInputSubmitCallback: (text) {
          Get.back(result: text);
        },
        searchBarInputChangeCallback: (text) {},
        onClearTap: () {},
        dismissClickCallback: (controller, update) {
          Get.back();
        },
      ),
    );
  }
}
