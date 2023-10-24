import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/goods_detail_model.dart';
import 'package:mallxx_app/app/modules/goods_detail/controllers/goods_detail_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';

class CookbookEvaluateView extends GetView<GoodsDetailController> {
  const CookbookEvaluateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: GetBuilder<GoodsDetailController>(
        builder: (c) {
          return EasyRefresh.builder(
            controller: c.cookEasyRefreshController,
            onLoad: c.onCookbookLoadMore,
            childBuilder: (_, physics) {
              return c.cookbookList.isNotEmpty
                  ? CustomScrollView(
                      physics: physics,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                buildItem(c.cookbookList[index]),
                            childCount: c.cookbookList.length,
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text('暂无评价'));
            },
          );
        },
      ),
    );
  }

  Widget buildItem(CookbookEvaluateItemModel m) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
            arguments: {'adId': m.id, 'type': 3});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
              left: Radius.circular(7.w),
              right: Radius.circular(7.w),
            )),
            child: Image(
              image: NetworkImage(m.image!),
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Text(m.title!, style: TextStyle(fontSize: 14.sp))
              .paddingSymmetric(vertical: 12.w),
          Align(
            alignment: Alignment.centerRight,
            child: Text(m.createtime!,
                style: TextStyle(color: kAppSubGrey99Color, fontSize: 13.sp)),
          )
        ],
      ).paddingAll(10.w),
    );
  }
}
