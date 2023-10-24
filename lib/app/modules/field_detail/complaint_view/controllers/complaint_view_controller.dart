import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:oktoast/oktoast.dart';

class ComplaintViewController extends GetxController {
  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  late String phone;
  late String content;

  Future<void> onComplain() async {
    var res = await fieldProvider.complain(Get.arguments, phone, content);
    if (res.code == 200) {
      content = '';
      showToast('${res.msg}');
      Future.delayed(Duration(milliseconds: 500), () => Get.back());
    }
  }
}
