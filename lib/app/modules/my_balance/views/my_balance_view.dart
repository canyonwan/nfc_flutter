import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/balance_model.dart';
import 'package:mallxx_app/app/modules/guess_like/views/empty_view.dart';
import 'package:mallxx_app/app/modules/my_balance/controllers/my_balance_controller.dart';
import 'package:mallxx_app/const/colors.dart';

class MyBalanceView extends GetView<MyBalanceController> {
  const MyBalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(title: const Text('我的余额'), centerTitle: true),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(
                          text: '¥ ',
                          style: TextStyle(
                              fontSize: 11.sp, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: '${controller.data.balance ?? 0}',
                              style: TextStyle(
                                  fontSize: 24.sp, fontWeight: FontWeight.bold),
                            ),
                          ])),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Align(
                              alignment: Alignment(0.0, -0.8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14.h, horizontal: 12.w),
                                decoration: BoxDecoration(
                                  color: KWhiteColor,
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                margin:
                                    EdgeInsets.symmetric(horizontal: 31.5.w),
                                width: Get.width,
                                height: 160.h,
                                child: Column(
                                  children: [
                                    Text(
                                      '余额充值',
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ).paddingOnly(bottom: 20.w),
                                    Expanded(
                                        child: TextField(
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) =>
                                          controller.onChanged(value),
                                      decoration: InputDecoration(
                                        labelText: "金额",
                                        hintText: "请输入金额",
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        hintStyle:
                                            TextStyle(color: Colors.black26),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kAppSubGrey99Color),
                                        ),
                                      ),
                                    )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        OutlinedButton(
                                            onPressed: Get.back,
                                            child: Text('取消')),
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.generateBalanceOrder();
                                            },
                                            child: Text('确定')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: kAppColor,
                            borderRadius: BorderRadius.circular(7.w),
                          ),
                          child: Text('充值',
                              style: TextStyle(
                                  color: KWhiteColor, fontSize: 14.sp)),
                        ),
                      )
                    ],
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

  Widget _buildItem(BalanceItemModel m) {
    return ListTile(
      title: Text('${m.describe}', style: TextStyle(fontSize: 16.sp)),
      subtitle: Text('${m.createtime!}',
          style: TextStyle(fontSize: 12.sp, color: kAppSubGrey99Color)),
      trailing: Text('${m.price}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
    );
  }
}
