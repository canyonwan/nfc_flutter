import 'package:bruno/bruno.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/my_footprint_model.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../../../routes/app_pages.dart';
import '../../guess_like/views/empty_view.dart';
import '../controllers/my_footprint_controller.dart';

class MyFootprintView extends GetView<MyFootprintController> {
  const MyFootprintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的足迹'), centerTitle: true),
      body: controller.obx(
        (state) => EasyRefresh.builder(
          controller: controller.easyRefreshController,
          onRefresh: controller.onRefresh,
          onLoad: controller.onLoadMore,
          childBuilder: (_, physics) {
            return GetBuilder<MyFootprintController>(builder: (c) {
              return CustomScrollView(
                physics: physics,
                slivers: [
                  c.list.isNotEmpty
                      ? buildSliverList(c.list)
                      : SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(top: 200.w),
                            alignment: Alignment.center,
                            child: Text('暂无数据'),
                          ),
                        ),
                ],
              );
            });
          },
        ),
        onEmpty: EmptyView(),
        onLoading: BrnPageLoading(),
      ),
    );
  }

  Widget buildSliverList(List<MyFootprintItemModel> list) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: [
              Text(
                '${list[index].time}',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              ...List.generate(
                list[index].goodsList!.length,
                (idx) => GoodsItemView(list[index].goodsList![idx]),
              ).toList(),
            ],
          ),
          childCount: list.length,
        ),
      );

  Widget GoodsItemView(GoodsItemModel model) {
    return Container(
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(7.w),
      ),
      height: 137.w,
      padding: EdgeInsets.symmetric(vertical: 11.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.GOODS_DETAIL, arguments: model.id),
            child: Image.network('${model.goodsImage}',
                    width: 115.w, fit: BoxFit.cover)
                .paddingOnly(left: 10.w),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${model.goodsName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Text.rich(TextSpan(
                    text: '¥',
                    style: TextStyle(fontSize: 11.sp, color: Colors.red),
                    children: [
                      TextSpan(
                        text: '${model.goodsPrice}',
                        style: TextStyle(fontSize: 18.sp, color: Colors.red),
                      ),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSpecialPrice('${model.exclusivePrice}'),
                    GestureDetector(
                      onTap: () => controller.addGoodsToCart(model.id!),
                      child: Image.asset(
                          R.ASSETS_ICONS_CART_RADIUS_GREEN_CART_ICON_PNG,
                          width: 46.w),
                    )
                  ],
                ),
              ],
            ).paddingOnly(left: 10.w),
          ),
        ],
      ),
    );
  }

  // 优源专享
  Widget _buildSpecialPrice(String price) {
    return Row(
      children: [
        Text('优源专享', style: TextStyle(fontSize: 11.sp)),
        BubbleBox(
          shape: BubbleShapeBorder(
            border: BubbleBoxBorder(
              color: Color(0xffF8B041),
              width: 3,
            ),
            position: const BubblePosition.center(0),
            direction: BubbleDirection.left,
          ),
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          backgroundColor: Color(0xffF8B041),
          child: Text.rich(
            TextSpan(
              text: '¥',
              style: TextStyle(
                color: KWhiteColor,
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: price,
                  style: TextStyle(
                    color: KWhiteColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
