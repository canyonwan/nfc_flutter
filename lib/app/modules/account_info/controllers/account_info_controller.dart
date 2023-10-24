import 'package:get/get.dart';
import 'package:mallxx_app/app/models/account_info_model.dart';
import 'package:mallxx_app/app/modules/root/providers/member_provider.dart';
import 'package:mallxx_app/app/routes/app_pages.dart';
import 'package:oktoast/oktoast.dart';

class AccountInfoController extends GetxController
    with StateMixin<AccountInfoDataModel> {
  List<Map> settingsTitle = [
    {"name": "个人信息", "url": Routes.ACCOUNT_INFO},
  ];

  MemberProvider memberProvider = Get.find<MemberProvider>();
  AccountInfoDataModel data = AccountInfoDataModel();

  // 注销帐号选中我已阅读协议
  bool isRead = false;
  String agreementText = '';

  void changeRead(bool value) {
    isRead = value;
    update();
  }

  Future<void> getRemoveAccountInfo() async {
    var res = await memberProvider.removeAccountAgreement();
    agreementText = res.data!.content!;
    update();
  }

  // 确认注销
  Future<void> onSubmitRemoveAccount() async {
    if (!isRead) {
      showToast('请勾选注销协议');
      return;
    }
    var res = await memberProvider.removeAccount();
    if (res.code == 200) {
      Get.back();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      showToast(res.msg);
    }
  }

  @override
  void onInit() {
    getMemberInfo();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getMemberInfo() async {
    change(null, status: RxStatus.loading());
    final res = await memberProvider.queryAccountInfo();
    if (res.code == 200) {
      data = res.data!;
      change(res.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(res.msg));
    }
  }

  Future<void> changeMemberInfo(String value) async {
    final res = await Get.toNamed(Routes.CHANGE_MEMBER_NAME, arguments: value);
    data.memberName = res;
    update();
  }

  Future<void> changeGender(int value) async {
    await Get.toNamed(Routes.CHANGE_GENDER, arguments: value);
    getMemberInfo();
  }

  Future<void> changePhone(String value) async {
    await Get.toNamed(Routes.CHANGE_PHONE, arguments: value);
    getMemberInfo();
  }

  Future<void> changePwd() async {
    await Get.toNamed(Routes.CHANGE_PASSWORD);
    getMemberInfo();
  }

  Future<void> changeAvatar(String value) async {
    await Get.toNamed(Routes.CHANGE_MEMBER_AVATAR, arguments: value);
    getMemberInfo();
  }
}
