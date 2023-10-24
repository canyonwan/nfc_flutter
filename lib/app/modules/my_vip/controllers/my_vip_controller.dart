import 'package:get/get.dart';
import 'package:mallxx_app/app/models/vip_model.dart';
import 'package:mallxx_app/app/modules/order_payment/controllers/order_payment_controller.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:mallxx_app/const/resource.dart';
import 'package:mallxx_app/utils/enums.dart';

class MyVipController extends GetxController with StateMixin<VipDataModel> {
  final MemberProvider _memberProvider = Get.find<MemberProvider>();

  VipDataModel vipData = VipDataModel();
  List<PayWayModel> ways = [
    PayWayModel('1', R.ASSETS_IMAGES_WECHAT_PAYMENT_PNG),
    PayWayModel('2', R.ASSETS_IMAGES_ALIPAY_PAYMENT_PNG),
    PayWayModel('3', R.ASSETS_IMAGES_YU_E_PAYMENT_PNG),
  ];
  String currentWay = '1';

  @override
  void onInit() {
    getShowVip();
    super.onInit();
  }

  void onSelectWay(String way) {
    currentWay = way;
    update();
  }

  Future<void> getShowVip() async {
    change(null, status: RxStatus.loading());
    final res = await _memberProvider.queryShowVip();
    if (res.code == 200 && res.data != null) {
      vipData = res.data!;
      change(res.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> onPay() async {
    Get.toNamed(Routes.ORDER_PAYMENT, arguments: {
      'payPrice': vipData.cardPrice,
      'payType': PayTypeEnum.special
    });
  }
}
