import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/components/number_item.dart';
import 'package:mallxx_app/app/models/process_production_model.dart';
import 'package:mallxx_app/const/colors.dart';

import '../controllers/process_controller.dart';

class ProcessView extends GetView<ProcessController> {
  const ProcessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('加工'), centerTitle: true),
      body: controller.obx((state) => buildSafeArea,
          onLoading: Center(child: CircularProgressIndicator()),
          onEmpty: Center(child: Text('空空如也!'))),
    );
  }

  Widget get buildSafeArea {
    return Column(
      children: [
        _buildTip,
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.data.length + 1,
            itemBuilder: (_, int idx) {
              if (idx == controller.data.length) {
                return GetBuilder<ProcessController>(builder: (_) {
                  return Column(
                    children: [
                      if (_.calcResult.describle != null) _buildAmount(),
                      _buildAddress(),
                    ],
                  );
                });
              }
              return _buildItem(controller.data[idx]);
            },
          ),
        ),
        _buildBottom,
      ],
    );
  }

  Widget get _buildBottom {
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 12.5.h),
          decoration: BoxDecoration(color: Color(0xffE2EFCD)),
          child: Center(
            child: Text(
              '送达您选择的地址需要运费${controller.calcResult.shipFee ?? 0}元',
              style: TextStyle(fontSize: 13.sp, color: Color(0xff8BBF37)),
            ),
          ),
        ),
        Container(
          width: Get.width,
          padding: EdgeInsets.only(
            left: 19.w,
            right: 19.w,
            bottom: Get.mediaQuery.padding.bottom,
            top: 8.h,
          ),
          decoration: BoxDecoration(color: KWhiteColor),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 26.w),
                child: Text.rich(TextSpan(
                    text: '总计：',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                    ),
                    children: [
                      TextSpan(
                        text: '￥',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '${controller.calcResult.totalPrice ?? 0}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ])),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: controller.onSubmitOrder,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.5.h),
                    decoration: BoxDecoration(
                      color: Color(0xff8BBF37),
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                    child: Center(
                      child: Text(
                        '支付并开始加工',
                        style: TextStyle(color: KWhiteColor, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //  地址栏
  Widget _buildAddress() {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.symmetric(vertical: 12.5.w, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KWhiteColor,
      ),
      child: GetBuilder(
          id: 'useAddress',
          builder: (ProcessController _) {
            return GestureDetector(
              onTap: controller.onSelectAddress,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '请选择您的收货地址',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 12.w, color: Colors.grey)
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.w),
                    child: Text(
                      '${_.useAddress.address ?? ''}',
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ),
                  Text(
                    '${_.useAddress.addressName ?? ''} ${_.useAddress.addressPhone ?? ''}',
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  )
                ],
              ),
            );
          }),
    );
  }

  //  合计
  Widget _buildAmount() {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.symmetric(vertical: 12.5.w, horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        color: KWhiteColor,
      ),
      child: Center(
        child: Obx(() {
          return Text(
            controller.calcLoading == true
                ? '计算中..'
                : '${controller.calcResult.describle ?? ''}',
            style: TextStyle(
                color: Color(0xff8BBF37),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          );
        }),
      ),
    );
  }

  Container _buildItem(CanProcessedProductionModel model) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.symmetric(vertical: 6.5.w, horizontal: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w), color: KWhiteColor),
      child: Row(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            margin: EdgeInsets.only(right: 9.w),
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xff666666))),
            child: Image.network(
              '${model.goodsImage ?? 'https://dummyimage.com/115x115/000000/fff&text=Test'}',
              width: 115.w,
              height: 115.w,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${model.goodsName}', style: TextStyle(fontSize: 16.sp)),
                Text(
                  '${model.expense}',
                  style: TextStyle(fontSize: 13.sp, color: Color(0xff666666)),
                ),
                NumberItem(
                  number: model.count ?? 0,
                  isEnable: true,
                  addClick: (value) => controller.onIncrement(value, model),
                  subClick: (value) => controller.onIncrement(value, model),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 提示
  Widget get _buildTip {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 11.5.w),
      decoration: BoxDecoration(
        color: Color(0xffFEE6C1),
      ),
      child: Text(
        '你想把它加工成什么呢？请在以下选择你想加工成的商品。',
        style: TextStyle(fontSize: 13.sp, color: Color(0xff8E611B)),
      ),
    );
  }
}
