import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mallxx_app/app/modules/root/controllers/root_controller.dart';
import 'package:mallxx_app/const/colors.dart';

import '../../../../const/resource.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showSplash.isTrue) {
        return controller.countdownTime.value != 0 ? _buildSplash : _buildHome;
      } else {
        return _buildHome;
      }
    });
  }

  Scaffold get _buildSplash {
    return Scaffold(
      body: Obx(
        () => controller.img != ''
            ? SizedBox(
                width: Get.width,
                height: Get.height,
                child: Image.network(
                  '${controller.img}',
                  fit: BoxFit.fill,
                ),
              )
            : SizedBox(),
      ),
    );
  }

  Scaffold get _buildHome {
    return Scaffold(
      body: GetBuilder<RootController>(builder: (c) {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: c.pageController,
          onPageChanged: (index) => c.setCurrentIndex(index),
          children: c.pages,
        );
      }),
      bottomNavigationBar: GetBuilder<RootController>(builder: (c) {
        return BottomNavigationBar(
          currentIndex: c.currentIndex,
          onTap: (index) {
            c.jumpPage(index);
          },
          items: [
            BottomNavigationBarItem(
              label: "home".tr,
              icon: Image.asset(
                R.ASSETS_ICONS_TABS_FIELD_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_ICONS_TABS_FIELD_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "粮仓",
              icon: GetBuilder<RootController>(builder: (c) {
                if (c.cartGoodsCount != null)
                  return GFIconBadge(
                    child: Image.asset(
                      R.ASSETS_ICONS_TABS_GRANARY_PNG,
                      width: 25.w,
                      height: 25.w,
                    ),
                    counterChild: c.cartGoodsCount == 0
                        ? SizedBox()
                        : GFBadge(child: Text('${c.cartGoodsCount}')),
                  );
                else
                  return SizedBox();
              }),
              activeIcon: GetBuilder<RootController>(builder: (c) {
                if (c.cartGoodsCount != null)
                  return GFIconBadge(
                    child: Image.asset(
                      R.ASSETS_ICONS_TABS_GRANARY_ED_PNG,
                      width: 25.w,
                      height: 25.w,
                    ),
                    counterChild: c.cartGoodsCount == 0
                        ? SizedBox()
                        : GFBadge(child: Text('${c.cartGoodsCount}')),
                  );
                else
                  return SizedBox();
              }),
            ),
            BottomNavigationBarItem(
              label: "market".tr,
              icon: Image.asset(
                R.ASSETS_ICONS_TABS_MARKET_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_ICONS_TABS_MARKET_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "发现".tr,
              icon: Image.asset(
                R.ASSETS_ICONS_TABS_FIND_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_ICONS_TABS_FIND_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
            BottomNavigationBarItem(
              label: "account".tr,
              icon: Image.asset(
                R.ASSETS_ICONS_TABS_MINE_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
              activeIcon: Image.asset(
                R.ASSETS_ICONS_TABS_MINE_ED_PNG,
                width: 25.0.w,
                height: 25.0.w,
              ),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kAppColor,
          unselectedItemColor: const Color.fromRGBO(123, 123, 123, 1),
        );
      }),
    );
  }
}
