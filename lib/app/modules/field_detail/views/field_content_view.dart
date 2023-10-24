import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/field_detail_model.dart';
import 'package:mallxx_app/app/modules/field_detail/controllers/field_detail_controller.dart';
import 'package:mallxx_app/const/colors.dart';

//
class FieldContentView extends GetView {
  final FieldDetailDataModel model;

  FieldContentView(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showEdit = false;
    return Container(
      color: kBgF7Color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (model.ifInfo == 1)
            Column(
              children: [
                if (model.orderInfo != null) _buildOrderInfo(model.orderInfo!),
                if (model.counselorInfo != null)
                  _buildCounselorInfo(model.counselorInfo!),
                if (model.shareExplain != null)
                  _buildShareCard(model.shareTitle!, model.shareExplain!,
                      model.shareImage!, model.ifInfo!),
              ],
            ),
          Container(
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: KWhiteColor,
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.ifInfo == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTitle('以下内容所有人可见'),
                      GetBuilder<FieldDetailController>(builder: (_) {
                        return GestureDetector(
                          onTap: () {
                            _.editFieldContent();
                          },
                          child: Text('编辑', style: TextStyle(color: kAppColor))
                              .paddingSymmetric(horizontal: 10.w),
                        );
                      }),
                    ],
                  ),
                HtmlWidget(model.content!).paddingSymmetric(vertical: 10.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 订单
  Widget _buildOrderInfo(OrderInfoItemModel model) {
    return Container(
      padding: EdgeInsets.only(top: 24.5.h, bottom: 10.h, left: 11.w, right: 0),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 19.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTitle('订单信息'),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 7.5.w, vertical: 3.h),
                  color: kAppColor,
                  child: Text(
                    '预计收货时间: ${model.reapTime}',
                    style: TextStyle(fontSize: 12.sp, color: KWhiteColor),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '所属田地库: ${model.parentArticle}',
            style: TextStyle(fontSize: 13.sp, color: kAppBlackColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              '编号: ${model.serialNumber}',
              style: TextStyle(fontSize: 13.sp, color: kAppBlackColor),
            ),
          ),
          Text(
            '种模: ${model.claimName}*${model.num}${model.units}',
            style: TextStyle(fontSize: 13.sp, color: kAppBlackColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: DefaultTextStyle(
              style: TextStyle(color: kAppSubGrey99Color, fontSize: 13.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('下单时间: ${model.createtime}'),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text('合计: ${model.totalPrice}'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 专家
  Widget _buildCounselorInfo(TechnicalAdvisorModel model) {
    return GetBuilder<FieldDetailController>(builder: (c) {
      return Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 19.5.h),
              child: _buildTitle('技术顾问'),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                  child: Stack(
                    children: [
                      Image.network(model.image!,
                          width: 100.w, height: 100.w, fit: BoxFit.fill),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 3.h),
                          decoration: BoxDecoration(
                              color: kAppColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.w),
                                bottomRight: Radius.circular(10.w),
                              )),
                          child: Text(model.name!,
                              style: TextStyle(
                                  color: KWhiteColor, fontSize: 12.sp)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    model.introduce!,
                    style: TextStyle(fontSize: 13.sp, height: 1.4.h),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      c.onLaunchInBrowser(model.serviceUrl!);
                    },
                    child: Image.asset('assets/images/lianxikefu.png',
                        width: 80.w),
                  ),
                  GestureDetector(
                    onTap: () {
                      c.onClipPhone(model.phone!);
                    },
                    child: Image.asset('assets/images/yijianboda.png',
                        width: 80.w),
                  ),
                  GestureDetector(
                    onTap: () {
                      c.onCallPhone(model.phone!);
                    },
                    child: Image.asset('assets/images/fuzhidianhua.png',
                        width: 80.w),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // 分享
  Widget _buildShareCard(
      String title, String share_explain, String image, int ifEdit) {
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: KWhiteColor,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 19.5.h),
            child: _buildTitle('分享设置'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GetBuilder<FieldDetailController>(
                  id: 'updateFieldDetail',
                  builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyle(fontSize: 15.sp)),
                        Text(share_explain, style: TextStyle(fontSize: 15.sp)),
                        if (_.showShareEditInput)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              BrnInputText(
                                maxHeight: 150,
                                minHeight: 30,
                                minLines: 2,
                                maxLength: 20,
                                bgColor: Colors.white,
                                borderColor: Colors.black26,
                                borderRadius: 6,
                                textString: '',
                                textInputAction: TextInputAction.newline,
                                maxHintLines: 20,
                                hint: '请输入分享说明',
                                // padding: EdgeInsets.fromLTRB(20, 10, 20, 14),
                                onTextChange: (text) {
                                  _.shareSettingExplain = text;
                                  // model.text = text;
                                  // setState(() {});
                                },
                                onSubmit: (text) {
                                  _.shareSettingExplain = text;
                                },
                              ),
                              GestureDetector(
                                  onTap: () => _.onSaveShareSettingInput(),
                                  child: Text('保存',
                                          style: TextStyle(color: kAppColor))
                                      .paddingOnly(top: 10.w))
                            ],
                          )
                      ],
                    );
                  },
                ),
              ),
              if (ifEdit == 1)
                GetBuilder<FieldDetailController>(builder: (_) {
                  return GestureDetector(
                    onTap: () => _.onChangeShareEdit(),
                    child: Text('修改', style: TextStyle(color: kAppColor))
                        .paddingSymmetric(horizontal: 10.w),
                  );
                }),
              Image.network(image, width: 100.w, height: 100.w),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text.rich(
      TextSpan(
        text: title,
        style: TextStyle(
          color: kAppSubGrey99Color,
          fontSize: 15.sp,
        ),
        children: [
          TextSpan(
            style: TextStyle(
              color: Color(0xffCCCCCC),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
