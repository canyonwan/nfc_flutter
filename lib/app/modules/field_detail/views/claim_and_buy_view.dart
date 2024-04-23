import 'package:bubble_box/bubble_box.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/modules/field_detail/controllers/field_detail_controller.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

import '../../../models/granary_list_model.dart';
import '../../root/controllers/granary_controller.dart';

class ClaimAndBuyView extends GetView<FieldDetailController> {
  final List<GoodsItemModel> goodsList;
  final List<ClaimItemModel> claimList;
  final List<ChippedItemModel> chippedList;
  final List<GranaryItemModel> granaryList;
  const ClaimAndBuyView(
      this.goodsList, this.claimList, this.chippedList, this.granaryList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgF7Color,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        children: [
          ...granaryList.map((e) => granaryItem(e)).toList(),
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
                                    text: '${controller.timeRemaining}',
                                    style: TextStyle(
                                        color: kAppColor, fontSize: 12.sp),
                                  ),
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

  // 仓库item
  Widget granaryItem(GranaryItemModel data) {
    return GetBuilder<FieldDetailController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: KWhiteColor,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(13, 13, 13, 0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 21.w),
                    padding: EdgeInsets.only(top: 42.w),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.image!),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 25.5.w),
                          child: Text(
                            data.name ?? '暂无名称',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: KWhiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                    color: KWhiteColor, fontSize: 12.sp),
                                child: Column(
                                  children: [
                                    Text('剩余库存'),
                                    Text('${data.residueNum ?? '0'}'),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                height: 20.h,
                                width: 0.5.w,
                                decoration: BoxDecoration(color: KWhiteColor),
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                    color: KWhiteColor, fontSize: 12.sp),
                                child: Column(
                                  children: [
                                    Text('剩余保质期'),
                                    Text(
                                      data.ifExpire == 0
                                          ? '${data.expireTime}'
                                          : '已过期',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: data.ifExpire == 0
                                            ? KWhiteColor
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 捐赠/回收/去加工
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (data.ifExpire == 0 &&
                                      data.ifRecycle == 1) {
                                    controller
                                        .getCurrentPrice(data.recyclePrice!);
                                    Get.dialog(Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          recycleDialogContent(data, type: 1),
                                          Padding(
                                            padding: EdgeInsets.only(top: 14.h),
                                            child: GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Image.asset(
                                                R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                                                width: 35.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  }
                                },
                                child: Image.asset(
                                    data.ifExpire == 0 && data.ifRecycle == 1
                                        ? R.ASSETS_ICONS_GRANARY_HUISHOU_PNG
                                        : R.ASSETS_ICONS_GRANARY_BUHUISHOU_PNG,
                                    width: 50.w),
                              ),
                              SizedBox(width: 13.5),
                              GestureDetector(
                                onTap: () {
                                  if (data.ifExpire == 0) {
                                    controller
                                        .getCurrentPrice(data.recyclePrice!);
                                    Get.dialog(Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          recycleDialogContent(data, type: 2),
                                          Padding(
                                            padding: EdgeInsets.only(top: 14.h),
                                            child: GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Image.asset(
                                                R.ASSETS_ICONS_MARKET_PRESALE_CLOSE_ICON_PNG,
                                                width: 35.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  }
                                },
                                child: Image.asset(
                                  data.ifExpire == 0
                                      ? R.ASSETS_ICONS_GRANARY_JUANZENG_PNG
                                      : R.ASSETS_ICONS_GRANARY_UN_JUANZENG_PNG,
                                  width: 50.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          // onTap: () => data.ifExpire == 0 && data.ifRecycle == 1
                          //     ? controller.onProcess(data.id!)
                          //     : null,
                          onTap: () => data.ifProcess == 0
                              ? (data.ifExpire == 0
                                  ? controller.onProcess(data.id!)
                                  : null)
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                                // color: data.ifExpire == 0 && data.ifRecycle == 1
                                color: data.ifProcess == 0
                                    ? (data.ifExpire == 0
                                        ? Colors.orange
                                        : Colors.grey)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text('加工/兑换',
                                style: TextStyle(
                                    fontSize: 16, color: KWhiteColor)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.forwardOperationRecords(data.id!),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        '操作记录 >',
                        style:
                            TextStyle(fontSize: 13.sp, color: kAppGrey66Color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.ASSETS_ICONS_GRANARY_GRANARY_BG_PNG),
                  fit: BoxFit.cover,
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: KWhiteColor),
                child: Column(
                  children: [
                    Text('${data.createtime}',
                        style: TextStyle(fontSize: 13.sp)),
                    Text('${data.totalNum}', style: TextStyle(fontSize: 11.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // type: 1 回收; 2 捐赠
  Widget recycleDialogContent(GranaryItemModel data, {int type = 1}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Column(
        children: [
          if (type == 2)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Text('你确定要将以下数量的库存交由农副仓，并无偿捐赠给需要的人吗？',
                  textAlign: TextAlign.center),
            ),
          if (type == 1)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    '目前的回收价格为${data.recyclePrice}/${data.units}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '请选择你要回收的数量',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 80.w),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff666666)),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.onDecrement(data.recyclePrice!),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.5),
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide()),
                      ),
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff999999)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TextField(
                        controller: controller.granrayTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // suffixText: '${data.units}',
                          isDense: true,
                          hintText: '请输入数值',
                          hintStyle: TextStyle(
                            color: Color(0xffBBBBBB),
                            fontSize: 16.sp,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        controller.onIncrementCount(data.recyclePrice!),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.5),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide()),
                      ),
                      child: Text(
                        '+',
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff999999)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '剩余库存${data.residueNum}${data.units}',
            style: TextStyle(color: kAppGrey66Color),
          ).paddingOnly(bottom: 20.h),
          if (type == 1)
            GetBuilder<GranaryController>(builder: (_) {
              return Text.rich(TextSpan(
                  text: '本次回收您将获得：',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 13.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '${_.totalPrice}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '元',
                      style:
                          TextStyle(color: Color(0xff999999), fontSize: 13.sp),
                    ),
                  ]));
            }),
          GestureDetector(
            onTap: () {
              if (type == 1) {
                controller.onRecycle(data.id!);
              } else if (type == 2) {
                controller.onDonate(data.id!);
              }
            },
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 17.5.sp, vertical: 20.sp),
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xff8AC036),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '${type == 1 ? '确定回收' : '确定捐赠'}',
                  style: TextStyle(color: KWhiteColor, fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
