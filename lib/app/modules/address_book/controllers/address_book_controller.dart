import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/const/colors.dart';
import 'package:oktoast/oktoast.dart';

import '/app/components/hint.dart';
import '/app/models/address_model.dart';
import '/app/models/useinfo_model.dart';
import '/app/modules/address_book/components/edit_address_view.dart';
import '/app/providers/login_provider.dart';
import '../providers/address_provider.dart';

///

class AddressBookController extends GetxController {
  final AddressProvider addressProvider = Get.find<AddressProvider>();
  final LoginProvider loginProvider = Get.find<LoginProvider>();

  final addressList = RxList<MyAddressItem>();
  final isEdit = false.obs;
  late final UserInfoModel? memberInfo;
  final mp = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    memberInfo = loginProvider.getMember();
    getAddressList();
  }

  void getAddressList() async {
    final response = await addressProvider.getAddressList();
    if (response.code == 200) {
      addressList.value = response.data!;
    }
  }

  void setDefaultAddress(int index) async {
    for (int i = 0; i < addressList.length; i++) {
      MyAddressItem item = addressList[i];
      if (i == index) {
        item.isDefault = 1;
        item.addressId = item.id;
        if (memberInfo != null) {
          final res = await addressProvider.saveMyAddress(item);
          if (res.code == 200) showToast('修改成功');
        }
      } else {
        item.isDefault = 0;
      }
    }
    update(["checkBox"]);
  }

  void onSelectAddress(MyAddressItem address) {
    if (mp != null) {
      if (mp["isReturn"] == true) {
        Get.back(result: address);
      }
    }
  }

  void handlerDelete(MyAddressItem address) {
    Get.defaultDialog(
      title: "hint".tr,
      content: Text("delete_address_book".tr),
      onConfirm: () {
        Get.back();
        EasyLoading.show();
        addressList.remove(address);
        addressProvider.deleteAddress(address.id!).then((value) {
          if (value.code != 200) {
            Get.snackbar("hint".tr, value.msg);
          } else {
            getAddressList();
          }
        });
        EasyLoading.dismiss();
      },
      onCancel: () {},
      confirmTextColor: KWhiteColor,
      cancelTextColor: Colors.red,
      textConfirm: "delete".tr,
      textCancel: "cancel".tr,
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      buttonColor: Colors.red,
    );
  }

  // edit
  void handlerEditAddress(MyAddressItem address) {
    Get.to(
      () => EditAddressView(
        onConfirm: (MyAddressItem value) {
          addressProvider.saveMyAddress(value).then((res) {
            if (res.code == 200) {
              getAddressList();
              Get.back();
            } else {
              Hint.Error(res.msg);
            }
          });
          update();
        },
        address: address,
      ),
    );
  }

  // 使用这个地址
  void onUseThisAddress(MyAddressItem address) {
    Get.back(result: address);
  }
}
