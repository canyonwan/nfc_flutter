import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();

  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class UserInfoRootModel {
  UserInfoRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory UserInfoRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      UserInfoRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : UserInfoModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  UserInfoModel? data;
  int? code;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'msg': msg,
        'data': data,
        'code': code,
      };
}

class UserInfoModel {
  UserInfoModel({
    this.wxUnionid,
    this.wxSex,
    this.wxProvince,
    this.wxOpenid,
    this.wxNickname,
    this.wxHeadimgurl,
    this.wxCountry,
    this.wxCity,
    this.token,
    this.status,
    this.specialStartTime,
    this.specialEndTime,
    this.sex,
    this.restaurant,
    this.qrCode,
    this.printerSn,
    this.phone,
    this.payPass,
    this.payOrderId,
    this.noutoasiakasId,
    this.nextLoginTime,
    this.memberName,
    this.memberImg,
    this.memberGroupIds,
    this.loginErrorNum,
    this.lastLoginTime,
    this.isSpecial,
    this.isAdministrator,
    this.integral,
    this.id,
    this.hasPassword,
    this.createTime,
    this.consumptionTotal,
    this.bindName,
    this.balance,
    this.accountType,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> jsonRes) => UserInfoModel(
        wxUnionid: asT<String?>(jsonRes['wx_unionid']),
        wxSex: asT<String?>(jsonRes['wx_sex']),
        wxProvince: asT<String?>(jsonRes['wx_province']),
        wxOpenid: asT<String?>(jsonRes['wx_openid']),
        wxNickname: asT<String?>(jsonRes['wx_nickname']),
        wxHeadimgurl: asT<String?>(jsonRes['wx_headimgurl']),
        wxCountry: asT<String?>(jsonRes['wx_country']),
        wxCity: asT<String?>(jsonRes['wx_city']),
        token: asT<String?>(jsonRes['token']),
        status: asT<int?>(jsonRes['status']),
        specialStartTime: asT<Object?>(jsonRes['special_start_time']),
        specialEndTime: asT<Object?>(jsonRes['special_end_time']),
        sex: asT<int?>(jsonRes['sex']),
        restaurant: asT<Object?>(jsonRes['restaurant']),
        qrCode: asT<String?>(jsonRes['qr_code']),
        printerSn: asT<Object?>(jsonRes['printer_sn']),
        phone: asT<String?>(jsonRes['phone']),
        payPass: asT<String?>(jsonRes['pay_pass']),
        payOrderId: asT<int?>(jsonRes['pay_order_id']),
        noutoasiakasId: asT<Object?>(jsonRes['noutoasiakas_id']),
        nextLoginTime: asT<int?>(jsonRes['next_login_time']),
        memberName: asT<String?>(jsonRes['member_name']),
        memberImg: asT<String?>(jsonRes['member_img']),
        memberGroupIds: asT<Object?>(jsonRes['member_group_ids']),
        loginErrorNum: asT<int?>(jsonRes['login_error_num']),
        lastLoginTime: asT<int?>(jsonRes['last_login_time']),
        isSpecial: asT<int?>(jsonRes['is_special']),
        isAdministrator: asT<int?>(jsonRes['is_administrator']),
        integral: asT<int?>(jsonRes['integral']),
        id: asT<int?>(jsonRes['id']),
        hasPassword: asT<int?>(jsonRes['has_password']),
        createTime: asT<String?>(jsonRes['create_time']),
        consumptionTotal: asT<String?>(jsonRes['consumption_total']),
        bindName: asT<String?>(jsonRes['bind_name']),
        balance: asT<String?>(jsonRes['balance']),
        accountType: asT<int?>(jsonRes['account_type']),
      );

  String? wxUnionid;
  String? wxSex;
  String? wxProvince;
  String? wxOpenid;
  String? wxNickname;
  String? wxHeadimgurl;
  String? wxCountry;
  String? wxCity;
  String? token;
  int? status;
  Object? specialStartTime;
  Object? specialEndTime;
  int? sex;
  Object? restaurant;
  String? qrCode;
  Object? printerSn;
  String? phone;
  String? payPass;
  int? payOrderId;
  Object? noutoasiakasId;
  int? nextLoginTime;
  String? memberName;
  String? memberImg;
  Object? memberGroupIds;
  int? loginErrorNum;
  int? lastLoginTime;
  int? isSpecial;
  int? isAdministrator;
  int? integral;
  int? id;
  int? hasPassword;
  String? createTime;
  String? consumptionTotal;
  String? bindName;
  String? balance;
  int? accountType;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'wx_unionid': wxUnionid,
        'wx_sex': wxSex,
        'wx_province': wxProvince,
        'wx_openid': wxOpenid,
        'wx_nickname': wxNickname,
        'wx_headimgurl': wxHeadimgurl,
        'wx_country': wxCountry,
        'wx_city': wxCity,
        'token': token,
        'status': status,
        'special_start_time': specialStartTime,
        'special_end_time': specialEndTime,
        'sex': sex,
        'restaurant': restaurant,
        'qr_code': qrCode,
        'printer_sn': printerSn,
        'phone': phone,
        'pay_pass': payPass,
        'pay_order_id': payOrderId,
        'noutoasiakas_id': noutoasiakasId,
        'next_login_time': nextLoginTime,
        'member_name': memberName,
        'member_img': memberImg,
        'member_group_ids': memberGroupIds,
        'login_error_num': loginErrorNum,
        'last_login_time': lastLoginTime,
        'is_special': isSpecial,
        'is_administrator': isAdministrator,
        'integral': integral,
        'id': id,
        'has_password': hasPassword,
        'create_time': createTime,
        'consumption_total': consumptionTotal,
        'bind_name': bindName,
        'balance': balance,
        'account_type': accountType,
      };
}

/// 修改昵称
class ChangeUsernameRootModel {
  ChangeUsernameRootModel({
    this.code,
    this.data,
    this.msg,
  });

  factory ChangeUsernameRootModel.fromJson(Map<String, dynamic> json) =>
      ChangeUsernameRootModel(
        code: asT<int?>(json['code']),
        data: json['data'] == null
            ? null
            : ChangeUsernameDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String?>(json['msg']),
      );

  int? code;
  ChangeUsernameDataModel? data;
  String? msg;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'data': data,
        'msg': msg,
      };
}

class ChangeUsernameDataModel {
  ChangeUsernameDataModel({
    this.memberName,
  });

  factory ChangeUsernameDataModel.fromJson(Map<String, dynamic> json) =>
      ChangeUsernameDataModel(
        memberName: asT<String?>(json['member_name']),
      );

  String? memberName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'member_name': memberName,
      };
}
