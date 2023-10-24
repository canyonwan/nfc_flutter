import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';

class ChangeGenderController extends GetxController {
  MemberProvider memberProvider = Get.find<MemberProvider>();

  int current = 1;
  List<WayModel> ways = [WayModel(1, '男'), WayModel(2, '女')];

  @override
  void onInit() {
    current = Get.arguments;
    super.onInit();
  }

  Future<void> onSelectWay(int way) async {
    current = way;
    final res = await memberProvider.changeGender(current);
    if (res.code == 200) {
      EasyLoading.showSuccess(res.msg);
    }
    update();
  }
}

class WayModel {
  final int type;
  final String name;

  WayModel(this.type, this.name);
}
