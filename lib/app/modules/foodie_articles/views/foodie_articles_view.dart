import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/foodie_article_list_model.dart';
import 'package:mallxx_app/app/models/foodie_article_menu_model.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/foodie_articles_controller.dart';

class FoodieArticlesView extends GetView<FoodieArticlesController> {
  const FoodieArticlesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('吃货文章'),
        actions: [
          GestureDetector(
            onTap: controller.onShareFoodie,
            child: Image.asset(R.ASSETS_ICONS_FIELD_SHARE_ICON_PNG, width: 25.w)
                .marginOnly(right: 10.w),
          ),
        ],
      ),
      body: Row(
        children: [
          _buildLeftMenus(),
          Expanded(
            child: GetBuilder<FoodieArticlesController>(
              id: 'articles', // 用于区分不同的builder，避免重复刷新
              builder: (c) {
                if (c.articleLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (c.articles.isEmpty) {
                  return BrnAbnormalStateWidget(
                    isCenterVertical: true,
                    title: BrnStrings.noData,
                  );
                }

                return EasyRefresh.builder(
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
                                _buildArticle(c.articles[index]),
                            childCount: c.articles.length,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticle(FoodieArticleItemModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
      child: GestureDetector(
        onTap: () => controller.onToDetail(model.id),
        child: BrnShadowCard(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.5.w),
                    topRight: Radius.circular(7.5.w),
                  ),
                ),
                child: Image(
                  image: NetworkImage(model.image),
                  height: 140.w,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        '${model.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                    Text(
                      '${model.createtime}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftMenus() {
    return GetBuilder<FoodieArticlesController>(
      id: 'menus',
      builder: (c) {
        return Container(
          color: kBgGreyColor,
          width: 90.5.w,
          height: Get.height,
          child: ListView.builder(
            itemCount: c.menus.length,
            itemBuilder: (_, index) => _buildMenuItem(c.menus[index]),
          ),
        );
      },
    );
  }

  ConstrainedBox _buildMenuItem(FoodieArticleMenuItemModel model) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 90.5.w),
      child: GetBuilder<FoodieArticlesController>(
          id: 'menuTap',
          builder: (c) {
            return GestureDetector(
              onTap: () => c.onMenuTap(model.id),
              child: Container(
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                color: model.id == c.listId ? KWhiteColor : kBgGreyColor,
                alignment: Alignment.center,
                child: Text(
                  '${model.name}',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: model.id == c.listId
                        ? kAppBlackColor
                        : kAppSubGrey99Color,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
