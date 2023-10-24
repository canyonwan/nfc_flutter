import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/integral_list_model.dart';
import 'package:mallxx_app/app/modules/guess_like/views/empty_view.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/my_integral_controller.dart';

class MyIntegralView extends GetView<MyIntegralController> {
  const MyIntegralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('我的积分'), centerTitle: true),
      body: controller.obx(
        (state) => buildEasyRefresh,
        onEmpty: EmptyView(),
        onLoading: BrnPageLoading(),
        onError: (e) => Center(
          child: Text(e!),
        ),
      ),
    );
  }

  EasyRefresh get buildEasyRefresh {
    return EasyRefresh.builder(
      controller: controller.easyRefreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoadMore,
      childBuilder: (_, physics) {
        return CustomScrollView(
          physics: physics,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Text(
                    '${controller.data.integral ?? 0}',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(height: 12.w, color: kBgGreyColor)),
            SliverPadding(
              padding: EdgeInsets.only(top: 14.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItem(controller.list[index]),
                  childCount: controller.list.length,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildItem(IntegralItemModel m) {
    return ListTile(
      title: Text('${m.describe}', style: TextStyle(fontSize: 16.sp)),
      subtitle: Text('${m.createtime!})}',
          style: TextStyle(fontSize: 12.sp, color: kAppSubGrey99Color)),
      trailing: Text('${m.integral}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
    );
  }
}
