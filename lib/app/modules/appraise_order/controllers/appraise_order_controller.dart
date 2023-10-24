import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallxx_app/app/api/common_api.dart';
import 'package:mallxx_app/app/modules/root/providers/cart_provider.dart';
import 'package:oktoast/oktoast.dart';

class AppraiseOrderController extends GetxController {
  final CartProvider _cartProvider = Get.find<CartProvider>();
  final CommonProvider commonProvider =
      Get.put<CommonProvider>(CommonProvider());
  final ImagePicker _picker = ImagePicker();
  double rateValue = 0;
  int goodsId = 0;
  int orderId = 0;
  List<String> imageUrls = [];
  String contents = '';
  String goodsImage = '';
  bool isAnonymous = false;

  @override
  void onInit() {
    orderId = Get.arguments['orderId'];
    goodsId = Get.arguments['goodsId'];
    goodsImage = Get.arguments['img'];
    super.onInit();
  }

  void onRatingChanged(double value) {
    rateValue = value;
    update();
  }

  void onRadioChanged(bool value) {
    isAnonymous = value;
    update();
  }

  // 上传图片
  Future<void> onUploadImage() async {
    final XFile? result = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (result != null) {
      var fileTemp = await result.path;
      File file = File(fileTemp);
      EasyLoading.show();
      final res = await commonProvider.uploadImage(file);
      if (res.code == 200) {
        EasyLoading.showSuccess('上传成功');
        imageUrls.add(res.data!.imageUrl!);
        update();
      } else {
        EasyLoading.showError(res.msg!);
      }
    }
  }

  Future<void> onAppraise() async {
    final res = await _cartProvider.appraise(
      order_id: orderId,
      goods_id: goodsId,
      grade: rateValue,
      image_urls: imageUrls.join(','),
      contents: contents,
    );
    showToast(res.msg);
    Get.back();
  }
}
