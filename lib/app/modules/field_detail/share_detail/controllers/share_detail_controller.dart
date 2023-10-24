import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:oktoast/oktoast.dart';

class ShareDetailController extends GetxController {
  final FieldProvider fieldProvider = Get.find<FieldProvider>();
  HtmlEditorController controller = HtmlEditorController();

  String detail = '';
  String value = '';

  @override
  void onInit() {
    detail = Get.arguments['detail'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    controller.disable();
  }


  Future<void> onSubmit() async {
    var res = await fieldProvider
        .onEditFieldDetailAndExplain(Get.arguments['id'], content: value);
    showToast("${res.msg}");
    if (res.code == 200) {
      Get.back();
    }
  }
}
