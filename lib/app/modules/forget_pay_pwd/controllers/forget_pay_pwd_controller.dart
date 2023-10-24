import 'package:get/get.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:oktoast/oktoast.dart';

class ForgetPayPwdController extends GetxController {
  MemberProvider memberProvider = Get.find<MemberProvider>();

  String code = '';
  String payPwd = '';
  String rePayPwd = '';

  Future<void> onSendSms() async {
    final res = await memberProvider.sendSmsForForgetPayPwd();
    showToast(res.msg);
  }

  Future<void> onSubmit() async {
    final res = await memberProvider.forgetPayPwd(
      code: code,
      pay_pass: payPwd,
      re_pay_pass: rePayPwd,
    );
    showToast(res.msg);
  }
}
