import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/guess_like_model.dart';
import 'package:mallxx_app/app/modules/goods_detail/widgets/views/goods_item_view.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/guess_like_controller.dart';
import 'empty_view.dart';

class GuessLikeView extends GetView<GuessLikeController> {
  const GuessLikeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('猜你喜欢'), centerTitle: true),
        body: controller.obx(
          (state) => EasyRefresh.builder(
            controller: controller.easyRefreshController,
            onRefresh: controller.onRefresh,
            onLoad: controller.onLoadMore,
            childBuilder: (_, physics) {
              return GetBuilder<GuessLikeController>(builder: (c) {
                return Column(
                  children: [
                    if (c.showTags)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.w, horizontal: 10.w),
                        child: DefaultTextStyle(
                          style:
                              TextStyle(fontSize: 14.sp, color: kAppBlackColor),
                          child: Row(
                            children: c.tags
                                .map((e) => GestureDetector(
                                      onTap: () => c.onSelectTag(e['value']),
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30.w),
                                        child: Text(e['label'],
                                            style: TextStyle(
                                                color:
                                                    e['value'] == c.currentTag
                                                        ? kAppBlackColor
                                                        : kAppSubGrey99Color)),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    Expanded(
                      child: CustomScrollView(
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
                      ),
                    ),
                  ],
                );
              });
            },
          ),
          onEmpty: EmptyView(),
          onLoading: BrnPageLoading(),
        ));
  }

  Widget buildSliverList(List<GuessGoodsModel> list) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GoodsItemView(
            list[index],
            onTap: (int goodsId) => {controller.addGoodsToCart(goodsId)},
          ),
          childCount: list.length,
        ),
      );
}
