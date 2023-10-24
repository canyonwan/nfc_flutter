import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '/app/modules/language/controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('language'.tr),
        centerTitle: true,
      ),
      body: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: Colors.black12,
          );
        },
        itemBuilder: (context, index) {
          return Obx(
            () {
              bool isSelect = false;
              if (controller.languageCode != null) {
                isSelect = controller.languageCode ==
                    (controller.langugeList[index].value.language +
                        "-" +
                        controller.langugeList[index].value.country);
              }

              return ListTile(
                title: Text(controller.langugeList[index].value.name),
                onTap: () {
                  controller.setSelected(index);
                  print(controller.langugeList[index]);
                },
                trailing: isSelect == true
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Container(
                        height: 1,
                        width: 1,
                      ),
              );
            },
          );
        },
        itemCount: controller.langugeList.length,
      ),
    );
  }
}
