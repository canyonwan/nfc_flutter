import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';

import '/app/models/address_model.dart';
import '../controllers/address_book_controller.dart';

class AddressBookView extends GetView<AddressBookController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: buildAppBar,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Obx(
              () => ListView.builder(
                itemCount: controller.addressList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index != controller.addressList.length) {
                    MyAddressItem address = controller.addressList[index];
                    return _buildAddressItem(address, index);
                  } else {
                    return SizedBox(height: 80);
                  }
                },
              ),
            ),
            _buildAddAddress(context)
          ],
        ),
      ),
    );
  }

  // 添加收货地址
  Positioned _buildAddAddress(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color: KWhiteColor,
        child: GestureDetector(
          onTap: () {
            controller.handlerEditAddress(MyAddressItem(addressId: 0));
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: kAppColor,
            ),
            child: Text(
              " + 添加收货地址",
              style: TextStyle(color: KWhiteColor, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  // 地址item
  Widget _buildAddressItem(MyAddressItem address, int index) {
    return GestureDetector(
      onTap: () => controller.onUseThisAddress(address),
      child: Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address.addressName!,
                  style: TextStyle(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  address.addressPhone!,
                  style: TextStyle(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: Row(
                children: [
                  if (address.isDefault == 1)
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.only(right: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Text('默认',
                          style: TextStyle(color: KWhiteColor, fontSize: 8.sp)),
                    ),
                  Text(
                    '${address.province!} ${address.city} ${address.county} ${address.address}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<AddressBookController>(
                  id: "checkBox",
                  init: controller,
                  builder: (_) => Row(
                    children: [
                      Checkbox(
                        tristate: true,
                        shape: const CircleBorder(),
                        activeColor: kAppColor,
                        checkColor: KWhiteColor,
                        hoverColor: KWhiteColor,
                        focusColor: kAppColor,
                        side: const BorderSide(color: Colors.grey, width: 1),
                        value: address.isDefault == 1,
                        onChanged: (bool? isCheck) =>
                            controller.setDefaultAddress(index),
                      ),
                      Text(
                        "默认地址",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.handlerEditAddress(address),
                  child: Text('编辑'),
                ),
                GestureDetector(
                  onTap: () => controller.handlerDelete(address),
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever),
                      Text(
                        '删除',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      title: Text('my_address_book'.tr),
      centerTitle: true,
    );
  }
}
