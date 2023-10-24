import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/granary_operation_records_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/operation_records_controller.dart';

class OperationRecordsView extends GetView<OperationRecordsController> {
  const OperationRecordsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(title: const Text('操作记录'), centerTitle: true),
      body: controller.obx(
        (state) => EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: controller.onRefresh,
          onLoad: controller.onLoadMore,
          childBuilder: (_, physics) {
            return CustomScrollView(
              physics: physics,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        recordItem(controller.recordData.recordList![index]),
                    childCount: controller.recordData.recordList!.length,
                  ),
                ),
              ],
            );
          },
        ),
        onLoading: Center(child: CircularProgressIndicator()),
        onEmpty: empty(),
      ),
    );
  }

  Widget recordItem(RecordListItemModel model) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.symmetric(vertical: 14.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KWhiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(color: Color(0xff666666), fontSize: 15.sp),
                ),
                Text(
                  '库存',
                  style: TextStyle(color: Color(0xff666666), fontSize: 15.sp),
                ),
              ],
            ),
          ),
          ...model.list!.map((e) {
            return ListTile(
              title: Text(
                e.status ?? '',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                e.createtime ?? '',
                style: TextStyle(fontSize: 12.sp, color: Color(0xff999999)),
              ),
              trailing: Text(
                e.num ?? '',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            );
          }).toList()
        ],
      ),
    );
  }

  // 空
  Widget empty() {
    return Center(
      child: Text(
        '操作是空的',
        style: TextStyle(fontSize: 13, color: Color(0xff666666)),
      ),
    );
  }
}
