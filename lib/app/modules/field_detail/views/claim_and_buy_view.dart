import 'package:bubble_box/bubble_box.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/modules/field_detail/controllers/field_detail_controller.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class ClaimAndBuyView extends GetView<FieldDetailController> {
  final List<GoodsItemModel> goodsList;
  final List<ClaimItemModel> claimList;
  final List<ChippedItemModel> chippedList;

  const ClaimAndBuyView(this.goodsList, this.claimList, this.chippedList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgF7Color,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        children: [
          ...claimList.map((e) => _buildClaimItem(e)).toList(),
          ...chippedList.map((e) => _buildChippedItem(e)).toList(),
          _buildGoodsGrid(),
        ],
      ),
    );
  }

  // 认领列表
  Container _buildClaimItem(ClaimItemModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(6.w),
        border: Border.all(width: 1, color: Color(0xffF2F2F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 7.5.w, horizontal: Get.width / 8),
              color: kAppLightColor,
              child: Text(
                '${model.reapTime}',
                style: TextStyle(
                    color: kAppColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 9.w, bottom: 18.w, left: 10.5, right: 10.5),
            child: Text(
              model.name ?? '无标题',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  color: kAppBlackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.5.w, left: 10.5, right: 10.5),
            child: Text(
              model.describe ?? '无描述',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: kAppSubGrey99Color,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.5.w, left: 10.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          text: model.price,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: '  /${model.units}',
                              style: TextStyle(
                                color: kAppSubGrey99Color,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      _buildSpecialPrice(model.exclusivePrice!)
                    ],
                  ),
                ),
                GetBuilder<FieldDetailController>(
                  builder: (c) {
                    return GestureDetector(
                      onTap: () => c.jumpToFieldClaim(model.id!),
                      child: Image.asset(R.ASSETS_IMAGES_RENLINGCHANNENG_PNG,
                          height: 25.h),
                    );
                  },
                ),
              ],
            ),
          )
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

// 合买列表
  Widget _buildChippedItem(ChippedItemModel model) {
    Duration differenceTime =
        DateTime.fromMillisecondsSinceEpoch(model.lastTime!).difference(
            DateTime.fromMillisecondsSinceEpoch(DateUtil.getNowDateMs()));
    controller.receiveTimeValue(model.lastTime!);
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width - 20.w),
      margin: EdgeInsets.symmetric(vertical: 10.w),
      padding: EdgeInsets.only(bottom: 13.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.5.w),
            ),
            child: Image.network(
              model.goodsImage!,
              width: 160.w,
              height: 160.w,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BubbleBox(
                    backgroundColor: kAppLightColor,
                    shape: BubbleShapeBorder(
                      radius: BorderRadius.only(
                        topRight: Radius.elliptical(30, 15),
                        bottomLeft: Radius.elliptical(30, 15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Text.rich(
                            TextSpan(
                                text: '距结束：',
                                style: TextStyle(
                                    color: kAppSubGrey99Color, fontSize: 11.sp),
                                children: [
                                  TextSpan(
                                    text:
                                        '${controller.timeRemaining.split('天').first}天',
                                    style: TextStyle(
                                        color: kAppColor, fontSize: 11.sp),
                                  ),
                                  TextSpan(
                                      text:
                                          '${controller.timeRemaining.split('天').last}',
                                      style: TextStyle(color: kAppColor)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13.w, bottom: 9.w),
                    child: Text(
                      '${model.goodsName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kAppBlackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '¥',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: model.goodsPrice,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.onJumpToGoodsDetail(model.id!),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.w, horizontal: 5.w),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.w),
                          ),
                          child: Text(
                            '立即参与',
                            style: TextStyle(color: KWhiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.w, top: 8.w),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 10),
                        CircleAvatar(radius: 10),
                        CircleAvatar(
                          backgroundColor: Color(0xffF2F2F2),
                          radius: 10,
                          child: Text('参与',
                              style:
                                  TextStyle(fontSize: 7.sp, color: kAppColor)),
                        ),
                        SizedBox(width: 4.w),
                        BubbleBox(
                          shape: BubbleShapeBorder(
                            border: BubbleBoxBorder(color: kAppColor, width: 1),
                            position: const BubblePosition.center(0),
                            direction: BubbleDirection.left,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 3.w),
                          backgroundColor: KWhiteColor,
                          child: Text(
                            '已有${model.chippedNum}人参与',
                            style: TextStyle(color: kAppColor, fontSize: 10.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
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
          )
        ],
      ),
    );
  }

//  商品列表
  Widget _buildGoodsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 10.h),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.51,
        mainAxisSpacing: 10.5.w,
        crossAxisSpacing: 6.w,
      ),
      itemCount: goodsList.length,
      itemBuilder: (_, int index) => _buildGoodsItem(goodsList[index]),
    );
  }

  Widget _buildGoodsItem(GoodsItemModel model) {
    return GestureDetector(
      onTap: () => controller.onJumpToGoodsDetail(model.id!),
      child: Container(
        decoration: BoxDecoration(
          color: KWhiteColor,
          // border: Border.all(width: 1, color: Color(0xffF2F2F2)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.5.w),
            topRight: Radius.circular(7.5.w),
          ),
        ),
        child: Column(
          children: [
            // Image.network(model.goodsImage!,
            //     width: 174.w, height: 174.w, fit: BoxFit.fill),
            model.ifSellOut == 1
                ? Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.black.withOpacity(.6),
                              Colors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds);
                        },
                        // child: Image(
                        //   image: NetworkImage(model.goodsImage!),
                        //   fit: BoxFit.fill,
                        //   width: Get.width,
                        // ),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(7.5.w),
                              topRight: Radius.circular(7.5.w),
                            ),
                          ),
                          child: Image.network(model.goodsImage!,
                              width: 174.w, height: 174.w, fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4.w),
                          color: Colors.black.withOpacity(.5),
                          alignment: Alignment.center,
                          child: Text('已卖完',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )
                : Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.5.w),
                        topRight: Radius.circular(7.5.w),
                      ),
                    ),
                    child: Image(
                        image: NetworkImage(model.goodsImage!),
                        width: 174.w,
                        height: 174.w,
                        fit: BoxFit.fill),
                  ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 13.5.w, top: 9.5.w, left: 5.5.w, right: 5.5.w),
                child: Text(
                  '${model.goodsName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.2.h,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: model.goodsPrice,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '  /箱',
                                style: TextStyle(
                                  color: kAppSubGrey99Color,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.5.w),
                        _buildSpecialPrice(model.exclusivePrice!)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.addGoods(model.id!),
                  child: Image.asset(R.ASSETS_IMAGES_FIELD_DETAIL_CART_PNG,
                      width: 46.w),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 9.5.w, top: 17.5.w, left: 5.5.w, right: 5.5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '销量: ${model.salesVolume}',
                    style:
                        TextStyle(fontSize: 10.sp, color: kAppSubGrey99Color),
                  ),
                  Text(
                    '评价: ${model.evaluationNumber}',
                    style:
                        TextStyle(fontSize: 10.sp, color: kAppSubGrey99Color),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEndTimeBox(String time) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: kAppColor,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Text(
        time,
        style: TextStyle(color: KWhiteColor, fontSize: 10.sp),
      ),
    );
  }
}
