import 'package:better_video_player/better_video_player.dart';
import 'package:bruno/bruno.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/ad_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../controllers/my_activity_forecast_controller.dart';

class MyActivityForecastView extends GetView<MyActivityForecastController> {
  const MyActivityForecastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      body: controller.obx(
          (m) => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                        title: Text('${m!.title}'),
                        pinned: true,
                        actions: [
                          IconButton(
                              onPressed: controller.onShare,
                              icon: Icon(Icons.share_outlined))
                        ]),
                  ];
                },
                body: ListView(
                  padding: EdgeInsets.only(bottom: 20.w),
                  children: [
                    if (m!.voucherList!.isNotEmpty) _buildVouchers(m),
                    // 代金券
                    if (![null, ''].contains(m.videoFile)) _buildVideo(m),
                    if (m.content != null)
                      HtmlWidget(m.content!).paddingAll(10.w),
                    // video
                    if (m.originArticles!.isNotEmpty) _buildField(m),
                    // field
                    if (m.goodsList!.isNotEmpty) _buildGoodsList(m),
                    // field
                  ],
                ),
              ),
          onError: (e) =>
              BrnAbnormalStateWidget(isCenterVertical: true, title: '$e'),
          onLoading: BrnPageLoading()),
    );
  }

  Widget _buildVouchers(ADDataModel m) {
    return GestureDetector(
      onTap: () => controller.onReceiveVoucher(m.voucherList!.first.id!),
      child: Container(
        width: Get.width,
        height: 150.w,
        margin: EdgeInsets.only(bottom: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(color: kAppColor),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(R.ASSETS_ICONS_MINE_AD_DAIJINQUAN_BG_PNG),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 44.w, left: 30.w),
            child: Row(
              children: [
                Column(
                  children: [
                    Text.rich(TextSpan(
                        text: '¥',
                        style: TextStyle(fontSize: 11.sp, color: kAppColor),
                        children: [
                          TextSpan(
                            text: '${m.voucherList!.first.price}',
                            style: TextStyle(fontSize: 30.sp, color: kAppColor),
                          ),
                        ])),
                    Text('满${m.voucherList!.first.full}可用',
                        style:
                            TextStyle(fontSize: 11.sp, color: kAppGrey66Color)),
                  ],
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${m.voucherList!.first.name}',
                        style: TextStyle(fontSize: 15.sp)),
                    Text('${m.voucherList!.first.endTime}',
                        style: TextStyle(
                            fontSize: 12.sp, color: kAppSubGrey99Color)),
                    Text('${m.voucherList!.first.explain}',
                        style: TextStyle(
                            fontSize: 12.sp, color: kAppSubGrey99Color)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildVideo(ADDataModel? m) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(7.w),
          bottomRight: Radius.circular(7.w),
        ),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: BetterVideoPlayer(
              controller: controller.videoController,
              configuration: BetterVideoPlayerConfiguration(
                autoPlay: false,
                placeholder: Image.network(
                  m!.videoImage!,
                  fit: BoxFit.contain,
                ),
              ),
              dataSource: BetterVideoPlayerDataSource(
                BetterVideoPlayerDataSourceType.network,
                m.videoFile!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(ADDataModel? item) {
    return Column(
        children:
            item!.originArticles!.map((e) => _buildFieldItem(e)).toList());
  }

  Widget _buildFieldItem(FieldItemModel? item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.FIELD_DETAIL, arguments: {"id": item!.id});
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: KWhiteColor,
              borderRadius: BorderRadius.circular(7.5.w),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(13, 13, 13, 0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item!.image != null && item.image!.length > 0)
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.5.w),
                        topRight: Radius.circular(7.5.w),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(item.image!),
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 11.5.w, bottom: 2.h, top: 4.h),
                  child: Text(
                    item.title!,
                    style: TextStyle(
                      color: Color(0xff606060),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.h,
            left: 12.w,
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 13.5.w),
              decoration: BoxDecoration(
                color: kAppColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.5.w),
                  bottomRight: Radius.circular(5.w),
                ),
              ),
              child: Text(
                '${item.describe!}',
                style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoodsList(ADDataModel? m) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 20.w,
      crossAxisSpacing: 10.w,
      childAspectRatio: 0.6,
      children: m!.goodsList!.map((item) => _buildGridItem(item)).toList(),
    );
  }

  Widget _buildGridItem(GoodsItemModel model) {
    return GestureDetector(
      onTap: () => controller.onToDetail(model.id!),
      child: Container(
        padding: EdgeInsets.only(bottom: 12.w),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(7.w),
        ),
        child: Column(
          children: [
            Container(
              // height: 154.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.5.w),
                  topRight: Radius.circular(7.5.w),
                ),
              ),
              child: Image(
                image: NetworkImage(model.goodsImage!),
                fit: BoxFit.fill,
                width: Get.width,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      model.goodsName ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 14.sp),
                    ).paddingSymmetric(vertical: 5.w),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: '¥',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: model.goodsPrice,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' /箱',
                                  style: TextStyle(
                                    color: kAppSubGrey99Color,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildSpecialPrice(model.exclusivePrice!),
                        ],
                      ),
                      SizedBox(width: 20),
                      Expanded(
                          child: GestureDetector(
                        onTap: () => controller.addGoods(model.id!),
                        child: Image.asset(
                            R.ASSETS_IMAGES_FIELD_DETAIL_CART_PNG,
                            width: 26.w),
                      )),
                    ],
                  ),
                  SizedBox(height: 6.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '销量: ${model.salesVolume}',
                        style: TextStyle(
                            fontSize: 10.sp, color: kAppSubGrey99Color),
                      ),
                      Text(
                        '评价: ${model.evaluationNumber}',
                        style: TextStyle(
                            fontSize: 10.sp, color: kAppSubGrey99Color),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ).paddingOnly(left: 10.w),
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
                    fontWeight: FontWeight.normal,
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
