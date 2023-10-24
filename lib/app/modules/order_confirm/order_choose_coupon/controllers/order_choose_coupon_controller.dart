import 'package:get/get.dart';
import 'package:mallxx_app/app/models/choose_coupon_list_model.dart';
import 'package:mallxx_app/app/modules/order_confirm/providers/order_confirm_provider.dart';

class OrderChooseCouponController extends GetxController
    with GetSingleTickerProviderStateMixin {
  OrderChooseCouponController({this.totalPrice});

  final OrderConfirmProvider orderConfirmProvider =
      Get.find<OrderConfirmProvider>();

  final String? totalPrice;

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  ChooseCouponListDataModel data = ChooseCouponListDataModel();
  int currentTab = 0;
  int selectedId = 0;
  List<String> tabs = [];

  Future<void> onChangeTab(int value) async {
    currentTab = value;
    update();
  }

  void onSelect(int value) async {
    selectedId = value;
    update();
  }

  void onSubmit() {
    Get.back(result: selectedId);
  }

  Future<void> getList() async {
    final res = await orderConfirmProvider.queryChooseCouponList(totalPrice!);
    if (res.code == 200) {
      data = res.data!;
      print('data: $data');
      update();
    }
  }
}
