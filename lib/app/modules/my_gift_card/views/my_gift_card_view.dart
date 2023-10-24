import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/models/gift_card_list_model.dart';
import 'package:mallxx_app/app/models/voucher_list_model.dart';
import 'package:mallxx_app/app/modules/my_gift_card/controllers/my_gift_card_controller.dart';
import 'package:mallxx_app/app/modules/root/views/market_view.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:mallxx_app/const/resource.dart';

class MyGiftCardView extends GetView<MyGiftCardController> {
  const MyGiftCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('卡券中心'), centerTitle: true),
      bottomNavigationBar: _buildBottomButtons,
      body: GetBuilder<MyGiftCardController>(builder: (c) {
        if (c.currentBottomType == 0) {
          return _buildGift();
        } else if (c.currentBottomType == 1) {
          return _buildVouchers();
        } else {
          return _buildBalance(context);
        }
      }),
    );
  }

  Widget _buildVouchers() {
    return GetBuilder<MyGiftCardController>(builder: (c) {
      return Column(
        children: [
          Container(
            color: KWhiteColor,
            child: BrnTabBar(
              isScroll: false,
              controller: controller.vouchersTabController,
              tabs: controller.tabs,
              onTap: (state, index) {
                controller.getVoucherList(index);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.vouchersTabController,
              children: [
                // 未使用
                Container(
                  child: controller.unusedVouchersList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.unusedVouchersList.length,
                          itemBuilder: (_, int idx) {
                            return _buildVouchersItem(
                                controller.unusedVouchersList[idx], 0);
                          },
                        )
                      : BrnAbnormalStateWidget(
                          isCenterVertical: true,
                          title: '暂无未使用代金券',
                        ),
                ),
                // 已使用
                Container(
                  child: controller.alreadyUsedVouchersList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.alreadyUsedVouchersList.length,
                          itemBuilder: (_, int idx) {
                            return _buildVouchersItem(
                                controller.alreadyUsedVouchersList[idx], 1);
                          },
                        )
                      : BrnAbnormalStateWidget(
                          isCenterVertical: true,
                          title: '暂无已使用代金券',
                        ),
                ),
                // // 已过期
                Container(
                  child: controller.expiredList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.expiredList.length,
                          itemBuilder: (_, int idx) {
                            return _buildVouchersItem(
                                controller.expiredList[idx], 2);
                          },
                        )
                      : BrnAbnormalStateWidget(
                          isCenterVertical: true,
                          title: '暂无已过期代金券',
                        ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  // 充值卡
  Widget _buildBalance(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GFButton(
            onPressed: () {
              Get.dialog(_buildRechargeDialogContent);
            },
            text: '使用充值卡',
            size: GFSize.LARGE,
            shape: GFButtonShape.pills,
            blockButton: true,
            color: kAppColor,
          ),
          GFButton(
            onPressed: () => Get.toNamed(Routes.BALANCE_USE_RECORD_LIST),
            text: "查看使用记录",
            color: KWhiteColor,
            size: GFSize.LARGE,
            borderSide: BorderSide(color: kAppColor),
            textColor: kAppColor,
            shape: GFButtonShape.pills,
            blockButton: true,
          ),
        ],
      ),
    );
  }

  // 礼品卡
  Widget _buildGift() {
    return GetBuilder<MyGiftCardController>(builder: (c) {
      return Column(
        children: [
          Container(
            color: KWhiteColor,
            child: BrnTabBar(
              controller: c.giftTabController,
              tabs: c.tabs,
              onTap: (state, index) {
                state.refreshBadgeState(index);
                c.getGiftList(index);
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: c.giftTabController,
              children: [
                // 未使用
                c.unusedGiftList.isNotEmpty
                    ? ListView.builder(
                        itemCount: c.unusedGiftList.length + 1,
                        itemBuilder: (_, int idx) {
                          if (c.unusedGiftList.length == idx) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GFButton(
                                  onPressed: () {
                                    Get.dialog(_buildDialogContent);
                                  },
                                  text: '绑定礼品卡',
                                  color: kAppColor,
                                  textColor: KWhiteColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  size: GFSize.LARGE,
                                  shape: GFButtonShape.pills,
                                ),
                                GFButton(
                                  onPressed: () {
                                    Get.to(() => MarketView());
                                  },
                                  text: '购买礼品卡',
                                  color: KWhiteColor,
                                  size: GFSize.LARGE,
                                  textColor: kAppColor,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  borderSide: BorderSide(color: kAppColor),
                                  shape: GFButtonShape.pills,
                                ),
                              ],
                            ).paddingSymmetric(vertical: 20.5.w);
                          }
                          return _buildGiftItem(c.unusedGiftList[idx], 1);
                        },
                      )
                    : BrnAbnormalStateWidget(
                        img: Image.asset(
                            R.ASSETS_ICONS_MINE_EMPTY_GIFT_CARD_PNG,
                            width: 100.w,
                            fit: BoxFit.cover),
                        title: '暂无礼品卡可用，小主可进行购买',
                        operateAreaType: OperateAreaType.doubleButton,
                        operateTexts: ['绑定礼品卡', '购买礼品卡'],
                        action: (int index) {
                          if (index == 0) {
                            Get.dialog(_buildDialogContent);
                          } else if (index == 1) {
                            Get.to(() => MarketView());
                          }
                          // BrnToast.show("第$_个按钮被点击了", context);
                        },
                      ),
                // 已使用
                c.usedGiftList.isNotEmpty
                    ? Container(
                        child: ListView.builder(
                          itemCount: c.usedGiftList.length,
                          itemBuilder: (_, int idx) {
                            return _buildGiftItem(c.usedGiftList[idx], 2);
                          },
                        ),
                      )
                    : BrnAbnormalStateWidget(
                        isCenterVertical: true,
                        title: '暂无已使用礼品卡',
                      ),
                // 已过期
                c.expiredGiftList.isNotEmpty
                    ? Container(
                        child: ListView.builder(
                          itemCount: c.expiredGiftList.length,
                          itemBuilder: (_, int idx) {
                            return _buildGiftItem(c.expiredGiftList[idx], 3);
                          },
                        ),
                      )
                    : BrnAbnormalStateWidget(
                        isCenterVertical: true,
                        title: '暂无已过期礼品卡',
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Align get _buildDialogContent {
    return Align(
      alignment: Alignment(0.0, -0.8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        margin: EdgeInsets.symmetric(horizontal: 31.5.w),
        width: Get.width,
        height: 160.h,
        child: Column(
          children: [
            Text(
              '绑定礼品卡',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ).paddingOnly(bottom: 20.w),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) => controller.onChanged(value),
              autofocus: true,
              decoration: InputDecoration(
                hintText: '请输入16位兑换码，不区分大小写',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GFButton(
                  text: '取消',
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  color: KWhiteColor,
                  textColor: kAppBlackColor,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                  onPressed: Get.back,
                ),
                GFButton(
                  text: '添加',
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  color: kAppColor,
                  textColor: KWhiteColor,
                  onPressed: controller.onAddGiftCard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container get _buildBottomButtons {
    return Container(
      color: KWhiteColor,
      height: 60.h,
      child: GetBuilder<MyGiftCardController>(builder: (c) {
        return DefaultTextStyle(
          style: TextStyle(fontSize: 24.sp),
          child: BrnSubSwitchTitle(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            nameList: ['礼品卡', '代金券', '充值卡'],
            defaultSelectIndex: controller.currentBottomType,
            onSelect: (value) {
              controller.onSelectBottom(value);
            },
          ),
        );
      }),
    );
  }

  Align get _buildRechargeDialogContent {
    return Align(
      alignment: Alignment(0.0, -0.8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        margin: EdgeInsets.symmetric(horizontal: 31.5.w),
        width: Get.width,
        height: 160.h,
        child: Column(
          children: [
            Text(
              '充值卡',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ).paddingOnly(bottom: 20.w),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) => controller.onRechargeChanged(value),
              autofocus: true,
              decoration: InputDecoration(
                hintText: '请输入充值卡号',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                ),
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GFButton(
                  text: '取消',
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  color: KWhiteColor,
                  textColor: kAppBlackColor,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  borderSide: BorderSide(color: kAppSubGrey99Color),
                  onPressed: Get.back,
                ),
                GFButton(
                  text: '充值',
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  size: GFSize.LARGE,
                  shape: GFButtonShape.pills,
                  color: kAppColor,
                  textColor: KWhiteColor,
                  onPressed: controller.onRecharge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVouchersItem(VoucherItemModel m, int type) {
    String bg = R.ASSETS_ICONS_MINE_NORMAL_TICKET_PNG;
    if (type == 0) {
      bg = R.ASSETS_ICONS_MINE_NORMAL_TICKET_PNG;
    } else if (type == 1) {
      bg = R.ASSETS_ICONS_MINE_USED_TICKET_PNG;
    } else if (type == 2) {
      bg = R.ASSETS_ICONS_MINE_YIGUOQI_TICKET_BG_PNG;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 26.w, horizontal: 14.5.w),
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 14.5.w),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bg), fit: BoxFit.fill),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                  text: '¥ ',
                  style: TextStyle(fontSize: 15.sp, color: KWhiteColor),
                  children: [
                    TextSpan(
                      text: '${m.price}',
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: KWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ])),
              Text('满${m.full}可用',
                  style: TextStyle(color: KWhiteColor, fontSize: 12.sp)),
            ],
          ),
          SizedBox(width: 26.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${m.name}',
                  style: TextStyle(color: KWhiteColor, fontSize: 18.sp)),
              SizedBox(height: 6.h),
              Text('有效期至：${m.endTime}',
                  style: TextStyle(color: KWhiteColor, fontSize: 12.sp)),
              Text('${m.explain}',
                  style: TextStyle(color: KWhiteColor, fontSize: 12.sp)),
            ],
          ),
          SizedBox(width: 20.w),
          if (type == 0)
            GFButton(
              text: '立即兑换',
              size: GFSize.SMALL,
              shape: GFButtonShape.pills,
              color: KWhiteColor,
              textColor: kAppColor,
              onPressed: () {
                controller.onExchange();
              },
            )
        ],
      ),
    );
  }

  Widget _buildGiftItem(GiftCardItemModel m, int type) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 14.5.w),
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 180.w,
            padding: EdgeInsets.fromLTRB(14.5.w, 0, 14.5.w, 16.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(type == 3
                    ? 'assets/images/gift_expired_bg.png'
                    : 'assets/images/gift_normal_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: KWhiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.w),
                      child: Text('${m.endTime}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: type == 3 ? kAppBlackColor : kAppColor,
                          )),
                    ),
                  ),
                  Text('${m.name}', style: TextStyle(fontSize: 15.sp)),
                  SizedBox(height: 10.5.w),
                  Text('${m.detail}', style: TextStyle(fontSize: 13.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Text('NO：${m.number}',
                            style: TextStyle(fontSize: 13.sp)),
                      ),
                      if (controller.currentBottomType == 0 &&
                          controller.giftTabController.index == 0)
                        GFButton(
                          onPressed: () => controller.onUseGiftCard(m.number),
                          text: '立即兑换',
                          color: KWhiteColor,
                          textColor: kAppColor,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          borderSide: BorderSide(color: kAppColor),
                          size: GFSize.MEDIUM,
                          shape: GFButtonShape.pills,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
