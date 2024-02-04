import 'package:flutter/material.dart';
import 'package:mallxx_app/app/models/account_info_model.dart';
import 'package:mallxx_app/app/models/ad_model.dart';
import 'package:mallxx_app/app/models/balance_model.dart';
import 'package:mallxx_app/app/models/commit_order_model.dart';
import 'package:mallxx_app/app/models/gift_card_list_model.dart';
import 'package:mallxx_app/app/models/guess_like_model.dart';
import 'package:mallxx_app/app/models/integral_list_model.dart';
import 'package:mallxx_app/app/models/my_footprint_model.dart';
import 'package:mallxx_app/app/models/notice_list_model.dart';
import 'package:mallxx_app/app/models/qr_code_model.dart';
import 'package:mallxx_app/app/models/remove_account_agreement_model.dart';
import 'package:mallxx_app/app/models/response_model.dart';
import 'package:mallxx_app/app/models/vip_model.dart';
import 'package:mallxx_app/app/models/voucher_list_model.dart';

import '/app/models/useinfo_model.dart';
import '/app/providers/base_provider.dart';

class MemberProvider extends BaseProvider {
  static const String loginUrl = '/apitest/member_login';
  static const String wxLoginUrl = 'apitest/wxLogin';
  static const String codeLoginUrl = 'apitest/phone_login';
  static const String changePhoneUrl = 'apitest/change_member_phone';
  static const String sendSmsForForgetPayPwdUrl = 'api/send_paypass_code';
  static const String forgetPayPwdUrl = 'api/change_paypass';
  static const String changePwdUrl = 'apitest/change_password'; // 修改登录密码
  static const String setNewPwdUrl = 'apitest/forget_pass'; // 忘记密码找回
  static const String changeUsernameUrl = 'apitest/change_member_name';
  static const String changeGenderUrl = 'apitest/change_member_sex';
  static const String registerUrl = '/apitest/member_register';
  static const String resetPayPwdUrl = 'apitest/change_member_pay_pass';
  static const String signOutUrl = '/sign/signout';
  static const String authCodeUrl = '/apizhibo/app_send_authcode';
  static const String accountInfoUrl = 'apitest/advertising';
  static const String guessLikeUrl = 'api/guess_like';
  static const String likeUrl = 'api/like_goods_list';
  static const String footprintUrl = 'api/goods_track_list';
  static const String dislikeUrl = 'api/dislike_goods_list';
  static const String editHealthUrl = 'apitest/restaurant';
  static const String integralListUrl = 'apitest/member_integral'; // 积分列表
  static const String voucherListUrl = 'api/member_voucher_list'; // 积分列表
  static const String balanceListUrl = 'api/member_balance_list'; // 余额明细列表
  static const String adDetailUrl = 'api/html_picture_content'; // 广告详细页面
  static const String swiperAdDetailUrl =
      'api/html_advertising_content'; // 轮播图页面
  static const String createBalanceOrderUrl =
      'api/receipt_create_order'; // 生成余额充值订单
  static const String giftCardListUrl = 'api/member_gift_list'; // 礼品卡列表
  static const String useGiftCardUrl = 'api/go_use_gift'; // 去使用礼品卡
  static const String bindGiftCardUrl = 'api/binding_gift'; // 绑定礼品卡
  static const String balanceCardUseListUrl =
      'api/use_balancecard_list'; // 充值卡使用记录
  static const String useBalanceCardUrl = 'api/use_balance_card'; // 使用余额充值卡
  static const String showVipUrl = 'api/show_vip'; // 会员信息
  static const String receiveVoucherUrl = 'api/member_get_voucher'; // 领取优惠券
  static const String queryMyQrCodeUrl = 'api/member_qr_code'; // 我的二维码
  static const String noticeListUrl = 'apitest/notice_list'; // 消息主列表
  static const String clearMessageUrl = 'apitest/empty_message'; // 清除未读
  static const String messageListListUrl =
      'apitest/message_list'; // 消息类型：1=系统通知，2=交易物流

  static const String messageDetailUrl = 'apitest/notice_del'; // 消息主列表
  static const String removeAccountAgreementUrl = 'api/remove_agree'; // 用户注销协议
  static const String removeAccountUrl = 'apitest/remove'; // 用户注销协议
  static const String setPayPwdUrl =
      'apitest/change_member_pay_pass'; // 首次设置支付密码
  @override
  void onInit() {
    super.onInit();
  }

  Future<UserInfoRootModel> login(
      {required String username, required String password}) async {
    final resp =
        await post(loginUrl, {'phone': username, 'password': password});
    return UserInfoRootModel.fromJson(resp.body);
  }

  Future<UserInfoRootModel> wxLogin({required String code}) async {
    final resp = await post(wxLoginUrl, {'code': code});
    debugPrint('login: ${resp.body}');
    return UserInfoRootModel.fromJson(resp.body);
  }

  Future<UserInfoRootModel> codeLogin(
      {required String phone, required String code}) async {
    final resp = await post(codeLoginUrl, {'phone': phone, 'code': code});
    return UserInfoRootModel.fromJson(resp.body);
  }

  Future<UserInfoRootModel> register(
      {required String username,
      required String password,
      required String code}) async {
    final resp = await post(
        registerUrl, {'phone': username, 'password': password, 'code': code});
    return UserInfoRootModel.fromJson(resp.body);
  }

  Future<ResponseData> signOut() async {
    final resp = await post(signOutUrl, null);
    return ResponseData.fromJson(resp.body);
  }

  Future<ResponseData> changePhone(
      {required String newphone, required String code}) async {
    final resp =
        await post(changePhoneUrl, {'newphone': newphone, 'code': code});
    return ResponseData.fromJson(resp.body);
  }

  Future<ResponseData> getVerification({required String username}) async {
    final resp = await post(authCodeUrl, {'phone': username});
    return ResponseData.fromJson(resp.body);
  }

  //  忘记支付密码的发送短信
  Future<ResponseData> sendSmsForForgetPayPwd() async {
    final resp = await post(sendSmsForForgetPayPwdUrl, {});
    return ResponseData.fromJson(resp.body);
  }

  //  忘记支付密码
  Future<ResponseData> forgetPayPwd(
      {required String code,
      required String pay_pass,
      required String re_pay_pass}) async {
    final resp = await post(forgetPayPwdUrl, {
      'code': code,
      'pay_pass': pay_pass,
      're_pay_pass': re_pay_pass,
    });
    return ResponseData.fromJson(resp.body);
  }

  // 帐户信息
  Future<AccountInfoRootModel> queryAccountInfo({String? location}) async {
    final resp = await post(accountInfoUrl, {'mergename': location});
    return AccountInfoRootModel.fromJson(resp.body);
  }

  // 修改昵称
  Future<ChangeUsernameRootModel> changeUsername(String username) async {
    final resp = await post(changeUsernameUrl, {'member_name': username});
    return ChangeUsernameRootModel.fromJson(resp.body);
  }

  // 修改密码
  Future<ResponseData> changePwd({
    required String password,
    required String newpassword,
    required String repassword,
  }) async {
    final resp = await post(changePwdUrl, {
      'password': password,
      'newpassword': newpassword,
      'repassword': repassword,
    });
    return ResponseData.fromJson(resp.body);
  }

  // 忘记密码
  Future<ResponseData> setNewPwd({
    required String phone,
    required String code,
    required String newpassword,
    required String repassword,
  }) async {
    final resp = await post(setNewPwdUrl, {
      'phone': phone,
      'code': code,
      'newpassword': newpassword,
      'repassword': repassword,
    });
    return ResponseData.fromJson(resp.body);
  }

  // 修改性别
  Future<ResponseData> changeGender(int sex) async {
    final resp = await post(changeGenderUrl, {'sex': sex});
    return ResponseData.fromJson(resp.body);
  }

  // 重置支付密码
  Future<ResponseData> resetPayPwd(
      {required String pay_pass,
      required String new_pay_pass,
      required String re_pay_pass}) async {
    final resp = await post(resetPayPwdUrl, {
      'pay_pass': pay_pass,
      'new_pay_pass': new_pay_pass,
      're_pay_pass': re_pay_pass
    });
    return ResponseData.fromJson(resp.body);
  }

  // 猜你喜欢
  Future<GuessLikeRootModel> queryGuessLikeList(int page) async {
    final resp = await post(guessLikeUrl, {'page': page});
    return GuessLikeRootModel.fromJson(resp.body);
  }

  // 喜欢
  Future<GuessLikeRootModel> queryLikeList(int page, int type) async {
    final resp = await post(likeUrl, {'page': page, 'type': type});
    return GuessLikeRootModel.fromJson(resp.body);
  }

  // 不喜欢
  Future<GuessLikeRootModel> queryDislikeList(int page, int type) async {
    final resp = await post(dislikeUrl, {'page': page, 'type': type});
    return GuessLikeRootModel.fromJson(resp.body);
  }

  // 足迹
  Future<MyFootprintRootModel> queryFootprintList(int page) async {
    final resp = await post(footprintUrl, {'page': page});
    return MyFootprintRootModel.fromJson(resp.body);
  }

  // 足迹
  Future<ResponseData> editHealth(String restaurant) async {
    final resp = await post(editHealthUrl, {'restaurant': restaurant});
    return ResponseData.fromJson(resp.body);
  }

  // 积分列表
  Future<IntegralRootModel> queryIntegralList(int page) async {
    final resp = await post(integralListUrl, {'page': page});
    return IntegralRootModel.fromJson(resp.body);
  }

  // 余额明细列表
  Future<BalanceRootModel> queryBalanceList(int page) async {
    final resp = await post(balanceListUrl, {'page': page});
    return BalanceRootModel.fromJson(resp.body);
  }

  // 代金券列表
  Future<VoucherListRootModel> queryVoucherList(int type) async {
    final resp = await post(voucherListUrl, {'type': type});
    return VoucherListRootModel.fromJson(resp.body);
  }

  // 礼品卡列表
  // 1是未使用,2是已使用
  Future<GiftCardListRootModel> queryGiftCardList(int type) async {
    final resp = await post(giftCardListUrl, {'type': type});
    return GiftCardListRootModel.fromJson(resp.body);
  }

  // 使用礼品卡列表
  Future<ResponseData> queryUseGiftCardUrl(String card_number,
      {String? addressId}) async {
    final resp = await post(
        useGiftCardUrl, {'card_number': card_number, 'address_id': addressId});
    return ResponseData.fromJson(resp.body);
  }

  // 绑定礼品卡列表
  Future<ResponseData> queryBindGiftCard(
    String card_number,
  ) async {
    final resp = await post(bindGiftCardUrl, {'card_number': card_number});
    return ResponseData.fromJson(resp.body);
  }

  // 使用充值卡
  Future<ResponseData> queryUseBalanceCardUrl(String cardNumber) async {
    final resp = await post(useBalanceCardUrl, {'number': cardNumber});
    return ResponseData.fromJson(resp.body);
  }

  // 充值卡使用记录
  Future<BalanceCardUseListRootModel> queryBalanceCardUseList() async {
    final resp = await post(balanceCardUseListUrl, {});
    return BalanceCardUseListRootModel.fromJson(resp.body);
  }

  // 生成余额充值订单
  Future<CartCommitOrderRootModel> createBalanceOrder(String price) async {
    final resp = await post(createBalanceOrderUrl, {'price': price});
    return CartCommitOrderRootModel.fromJson(resp.body);
  }

  // 广告详细页面
  Future<ADRootModel> queryAdDetail(int id) async {
    final resp = await post(adDetailUrl, {'advertisement_id': id});
    return ADRootModel.fromJson(resp.body);
  }

  // 轮播图页面
  Future<ADRootModel> querySwiperAdDetailUrl(int id) async {
    final resp = await post(swiperAdDetailUrl, {'advertisement_id': id});
    return ADRootModel.fromJson(resp.body);
  }

  // 会员信息
  Future<VipRootModel> queryShowVip() async {
    final resp = await post(showVipUrl, {});
    return VipRootModel.fromJson(resp.body);
  }

  // 领取优惠券
  Future<ResponseData> receiveVoucher(int voucherId, {int? num}) async {
    final resp = await post(
        receiveVoucherUrl, {'voucher_id': voucherId, 'num': num ?? 1});
    return ResponseData.fromJson(resp.body);
  }

  // 我的二维码
  Future<MyQRCodeRootModel> queryMyQrCode() async {
    final resp = await post(queryMyQrCodeUrl, {});
    print('queryMyQrCode resp: $resp');
    return MyQRCodeRootModel.fromJson(resp.body);
  }

  // 通知主列表
  Future<NoticeListRootModel> queryNoticeList(int page) async {
    final resp = await post(noticeListUrl, {'page': page});
    return NoticeListRootModel.fromJson(resp.body);
  }

  // 清除未读
  Future<ResponseData> clearMessage() async {
    final resp = await post(clearMessageUrl, {});
    return ResponseData.fromJson(resp.body);
  }

  // 消息类型：1=系统通知，2=交易物流
  Future<NoticeListRootModel> queryMessageList(int page, int type) async {
    final resp = await post(messageListListUrl, {'type': type, 'page': page});
    return NoticeListRootModel.fromJson(resp.body);
  }

  // 消息详情
  // 消息类型：1=系统通知，2=交易物流
  Future<MessageDetailRootModel> queryMessageDetail(int type, int id) async {
    final resp = await post(messageDetailUrl, {'type': type, 'id': id});
    return MessageDetailRootModel.fromJson(resp.body);
  }

  // 设置支付密码
  Future<ResponseData> setPayPwd(
      {required String new_pay_pass, required String re_pay_pass}) async {
    final resp = await post(setPayPwdUrl,
        {'new_pay_pass': new_pay_pass, 're_pay_pass': re_pay_pass});
    return ResponseData.fromJson(resp.body);
  }

  // 用户注销协议
  Future<RemoveAccountInfoRootModel> removeAccountAgreement() async {
    final resp = await post(removeAccountAgreementUrl, {});
    return RemoveAccountInfoRootModel.fromJson(resp.body);
  }

  // 用户注销
  Future<ResponseData> removeAccount() async {
    final resp = await post(removeAccountUrl, {});
    return ResponseData.fromJson(resp.body);
  }
}
