import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/guess_like_model.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

typedef clickCallback = void Function(int);

class GoodsItemView extends GetView {
  final GuessGoodsModel model;
  final clickCallback onTap;

  const GoodsItemView(this.model, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.GOODS_DETAIL, arguments: model.id),
      child: Container(
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(7.w),
        ),
        height: 137.w,
        padding: EdgeInsets.symmetric(vertical: 11.w),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
        child: Row(
          children: [
            Image.network('${model.goodsImage}',
                    width: 115.w, fit: BoxFit.cover)
                .paddingOnly(left: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${model.goodsName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                        onTap: () => onTap(model.id!),
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
