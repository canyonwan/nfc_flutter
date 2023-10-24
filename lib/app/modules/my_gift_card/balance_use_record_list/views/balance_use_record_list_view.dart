import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/balance_use_record_list_controller.dart';

class BalanceUseRecordListView extends GetView<BalanceUseRecordListController> {
  const BalanceUseRecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('使用记录'), centerTitle: true),
      body: controller.obx(
        (state) => ListView.separated(
          itemCount: controller.list.length,
          itemBuilder: (_, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.w),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 14.sp, color: kAppBlackColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.list[index].number!),
                    Text(controller.list[index].price!),
                    Text(controller.list[index].useTime!),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
        onEmpty: BrnAbnormalStateWidget(
          isCenterVertical: true,
          title: BrnStrings.noData,
        ),
        onLoading: BrnPageLoading(),
      ),
    );
  }
}
