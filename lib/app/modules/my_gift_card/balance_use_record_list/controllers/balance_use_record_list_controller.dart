import 'package:get/get.dart';
import 'package:mallxx_app/app/models/balance_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';

class BalanceUseRecordListController extends GetxController
    with StateMixin<List<CardBalanceItemModel>> {
  final MemberProvider memberProvider = Get.find<MemberProvider>();
  List<CardBalanceItemModel> list = [];

  @override
  void onInit() {
    queryList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> queryList() async {
    change(null, status: RxStatus.loading());
    final res = await memberProvider.queryBalanceCardUseList();
    if (res.code == 200) {
      if (res.data!.cardBalance!.isNotEmpty) {
        change(res.data!.cardBalance, status: RxStatus.success());
        list = res.data!.cardBalance!;
      } else if (res.data!.cardBalance!.isEmpty) {
        change(res.data!.cardBalance!, status: RxStatus.empty());
      }
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }
}
