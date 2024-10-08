import 'package:bruno/bruno.dart';
import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/modules/field_detail/controllers/field_detail_controller.dart';
import 'package:mallxx_app/app/modules/field_detail/views/components/build_option_item.dart';
import 'package:mallxx_app/app/modules/root/controllers/root_controller.dart';
import 'package:mallxx_app/const/colors.dart';

import '../../../../const/resource.dart';

class DecisionAndManageView extends GetView {
  final List<DecisionItemModel> decisionList;

  const DecisionAndManageView(this.decisionList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgF7Color,
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          children: decisionList.map((e) => _buildItem(e)).toList()),
    );
  }

  Container _buildItem(DecisionItemModel m) {
    BoxDecoration _border = BoxDecoration(
      color: KWhiteColor,
      borderRadius: BorderRadius.circular(6.w),
      border: Border.all(width: 1, color: kBgGreyColor),
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: _border,
      child: GetBuilder<FieldDetailController>(builder: (c) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
              color: kAppLightColor,
              child: Text(
                m.time ?? '无发布',
                style: TextStyle(
                    color: kAppColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 17.5.h, top: 12.h, left: 7.5.w),
              child: HtmlWidget(m.item ?? '无决策内容'),
              // child: Text(
              //   m.item ?? '无决策内容',
              //   style: TextStyle(
              //       fontSize: 15.sp,
              //       height: 1.5.h,
              //       fontWeight: FontWeight.bold),
              // ),
            ),
            if (m.decesionGoods!.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 10.h),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.51,
                  mainAxisSpacing: 10.5.w,
                  crossAxisSpacing: 6.w,
                ),
                itemCount: m.decesionGoods!.length,
                itemBuilder: (_, int index) =>
                    _buildGoodsItem(m.decesionGoods![index]),
              ),
            if (m.ifGranary == 1)
              GetBuilder<RootController>(builder: (_) {
                return GestureDetector(
                  onTap: () => {
                    Get.back(),
                    _.setCurrentIndex(1),
                    _.jumpPage(1),
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        R.ASSETS_ICONS_TABS_GRANARY_ED_PNG,
                        width: 25.w,
                        height: 25.w,
                      ),
                      Text('粮仓', style: TextStyle(color: kAppColor)),
                    ],
                  ).paddingOnly(left: 10.w, bottom: 10.h),
                );
              }),
            if (m.voucher != null)
              Container(
                width: Get.width,
                height: 100.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '￥${m.voucher!.price}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: kAppColor,
                            ),
                          ),
                          Text(
                            '满${m.voucher!.full}可用',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: kAppColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${m.voucher!.name}',
                          style: TextStyle(fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${m.voucher!.startTime}-${m.voucher!.endTime}',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: kAppColor,
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Text('立即领取',
                          style:
                              TextStyle(color: KWhiteColor, fontSize: 13.sp)),
                    )
                  ],
                ),
              ),
            ...m.optionList!
                .map((e) => BuildOptionItem(
                      onValueChange: (item) => c.onSelectOption(item, m),
                      item: e,
                      disabled: m.status!,
                    ))
                .toList(),
            if (m.countdown != '') _buildCountdown(m),
            Divider(indent: 15.w, endIndent: 15.w),
            // 我的选择
            Padding(
              padding: EdgeInsets.only(top: 14.h, left: 11.5.w),
              child: Text.rich(TextSpan(
                  text: '您的选择是：',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: kAppSubGrey99Color),
                  children: [
                    TextSpan(
                      text:
                          '${m.memberChoose == 0 ? '未选择' : '选项${m.memberChoose}'}',
                      style: TextStyle(
                          color: kAppColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '，还需进行以下操作：',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: kAppSubGrey99Color),
                    ),
                  ])),
            ),
            //  用户选项说明
            buildOptionExplain(_border, m),
            // 如果m.memberChoose是2，说明用户选择了第二个选项，那么就显示用户输入的内容
            if (m.content != '')
              Container(
                margin: EdgeInsets.symmetric(horizontal: 11.5.w),
                padding: EdgeInsets.all(10.5.w),
                child: Text(m.content!,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            if (m.image != '')
              Container(
                width: Get.width,
                height: 200.h,
                margin: EdgeInsets.symmetric(horizontal: 11.5.w),
                padding: EdgeInsets.all(10.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  image: DecorationImage(
                      image: NetworkImage(m.image!), fit: BoxFit.cover),
                ),
              ),
            if (m.status != 1)
              Text.rich(
                TextSpan(
                  text: '本次操作已支付费用：',
                  style: TextStyle(fontSize: 13.sp, color: kAppSubGrey99Color),
                  children: [
                    TextSpan(
                      text: '￥',
                      style: TextStyle(fontSize: 9.sp, color: kAppBlackColor),
                    ),
                    TextSpan(
                      text: '${m.totalPrice}',
                      style: TextStyle(fontSize: 13.sp, color: kAppBlackColor),
                    )
                  ],
                ),
              ).paddingSymmetric(horizontal: 13.w, vertical: 20.w),
            if (m.ifContent == 1) _buildUserInputContent(_border, m),
            if (m.ifImage == 1 && m.status == 1)
              _buildUploadImage(_border, c, m),
            if (m.status == 1) _buildPayment(m, c),
          ],
        );
      }),
    );
  }

  Widget _buildGoodsItem(DecesionGoodsItem model) {
    return GetBuilder<FieldDetailController>(builder: (controller) {
      return GestureDetector(
        onTap: () => controller.onJumpToGoodsDetail(model.id),
        child: Container(
          decoration: BoxDecoration(
            color: KWhiteColor,
            // border: Border.all(width: 1, color: Color(0xffF2F2F2)),
          ),
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
                child: Image.network(model.goodsImage,
                    width: 174.w, height: 174.w, fit: BoxFit.fill),
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
                          _buildSpecialPrice(model.exclusivePrice)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.addGoods(model.id),
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
    });
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

  // 倒计时
  Align _buildCountdown(DecisionItemModel m) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        padding: EdgeInsets.symmetric(vertical: 7.w, horizontal: 12.w),
        decoration: BoxDecoration(
            color: Color(0xffFFF6E7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              bottomLeft: Radius.circular(10.w),
            )),
        child: Text(
          m.countdown ?? '1',
          style: TextStyle(
            color: Color(0xffFFA320),
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //  用户选项说明
  Container buildOptionExplain(BoxDecoration _border, DecisionItemModel m) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.5.w, vertical: 10.h),
      padding: EdgeInsets.all(10.5.w),
      width: Get.width,
      decoration: _border,
      child: Text(
        m.statusName ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
          color: kAppBlackColor,
        ),
      ),
    );
  }

  // 价格展示, 并提交决策订单
  Padding _buildPayment(DecisionItemModel m, FieldDetailController c) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(
              text: '请确认支付费用：',
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: kAppSubGrey99Color),
              children: [
                TextSpan(
                  text: '￥',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: m.totalPrice ?? '0.00',
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ])),
          GestureDetector(
            onTap: () => c.onPayAndSubmit(m),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.w),
                color: kAppColor,
              ),
              child: Text(
                '支付并提交',
                style: TextStyle(fontSize: 12.sp, color: KWhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 允许用户输入文字
  Container _buildUserInputContent(BoxDecoration _border, DecisionItemModel m) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.w),
      decoration: _border,
      child: BrnInputText(
        autoFocus: false,
        maxHeight: 200,
        minHeight: 30,
        minLines: 3,
        maxLength: 50,
        textString: '',
        textInputAction: TextInputAction.newline,
        maxHintLines: 50,
        hint: '最多显示50个字',
        padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
        onTextChange: (text) {
          m.content = text;
        },
        onSubmit: (text) {
          m.content = text;
        },
      ),
    );
  }

  // 允许用户上传的图片
  Container _buildUploadImage(
      BoxDecoration _border, FieldDetailController c, DecisionItemModel m) {
    bool hasNetworkImage = false;
    if (m.image != '' || m.image != null) {
      hasNetworkImage = m.image!.contains('http');
    }
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 11.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(vertical: 40.w),
      decoration: _border,
      child: m.image == '' && c.fileTemp == null
          ? Column(
              children: [
                GestureDetector(
                  onTap: () => c.onUploadImage(m),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 40.w),
                    decoration: BoxDecoration(
                      color: kAppColor,
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                    child: Text(
                      '上传图片',
                      style: TextStyle(color: KWhiteColor, fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: 5.5.h),
                Text(
                  '仅限png、jpg jpeg等，大小不超过10M',
                  style: TextStyle(fontSize: 10.sp, color: kAppSubGrey99Color),
                ),
              ],
            )
          : hasNetworkImage
              ? Image.network(m.image!, height: 200.w)
              : Image.file(c.fileTemp!, fit: BoxFit.cover, height: 200.w),
    );
  }
}
