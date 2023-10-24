import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/find_model_entity.dart';
import 'package:mallxx_app/app/modules/root/controllers/find_controller.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class FindListView extends GetView<FindController> {
  final List<FindItemModel> findList;
  const FindListView(this.findList, {Key? key}) : super(key: key);

  Widget _buildItem(FindItemModel item) {
    return Container(
      margin: EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageWall(item),
          Expanded(
            child: Text(
              '${item.title}',
              maxLines: 2,
              style:
                  TextStyle(fontSize: 12.sp, overflow: TextOverflow.ellipsis),
            ).paddingSymmetric(horizontal: 8.w, vertical: 5.w),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item.browse}',
                  style: TextStyle(color: kAppSubGrey99Color, fontSize: 11.sp)),
              GestureDetector(
                onTap: () => controller.onCollect(item),
                child: GetBuilder<FindController>(
                    id: 'collect',
                    builder: (c) {
                      return Row(
                        children: [
                          Image.asset(
                            item.ifCollect == 0
                                ? R.ASSETS_ICONS_LIKE_PNG
                                : R.ASSETS_ICONS_LIKE_ED_PNG,
                            width: 22.w,
                          ).paddingOnly(right: 4.w),
                          Text(
                            '${item.collectNum}',
                            style: TextStyle(
                                color: kAppSubGrey99Color, fontSize: 11.sp),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ).paddingSymmetric(horizontal: 8.w, vertical: 5.w)
        ],
      ),
    );
  }

// 图片墙
  Widget _buildImageWall(FindItemModel item) {
    return GestureDetector(
      onTap: () => onJumpDetail(item.id!, item.type!),
      child: Container(
        height: 150.w,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.w),
            topRight: Radius.circular(6.w),
          ),
        ),
        child: Stack(
        fit: StackFit.expand,
          children: [
            Image.network(
              item.image!,
              fit: BoxFit.fill,
              width: Get.width,
              height: 150.w,

         ),
            if (item.type == 1)
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () { onJumpDetail(item.id!, item.type!); },
                child: Container(
                  // constraints: BoxConstraints.tightFor(width: 60, height: 60),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  ),
                  child: const Icon(Icons.play_arrow,
                      color: KWhiteColor, size: 40),
                ),

              ),
        ],
        ),
      ),
    );
  }

  void onJumpDetail(int id, int type) {
    if (type == 3) {
      // 打开吃货模式页
      Get.toNamed(Routes.MY_ACTIVITY_FORECAST,
          arguments: {'adId': id, 'type': 3});
    } else {
      Get.toNamed(Routes.FIND_DETAIL, arguments: {'adId': id, 'type': type});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 0.78,
      crossAxisCount: 2,
      children: findList.map((e) => _buildItem(e)).toList(),
    );
  }
}
