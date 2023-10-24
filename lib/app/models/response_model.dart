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

/// 通用响应model
class ResponseData {
  int code;
  String msg;

  ResponseData({required this.code, required this.msg});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(code: json["code"], msg: json["msg"]);
  }
}

/// 订单支付通用入参model
class OrderPaymentModel {
  OrderPaymentModel({
    required this.paymentCode,
    required this.payPass,
    this.orderSn,
  });

  factory OrderPaymentModel.fromJson(Map<String, dynamic> jsonRes) =>
      OrderPaymentModel(
        paymentCode: asT<String>(jsonRes['payment_code'])!,
        payPass: asT<String>(jsonRes['pay_pass'])!,
        orderSn: asT<String?>(jsonRes['order_sn']),
      );

  String paymentCode;
  String payPass;
  String? orderSn;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'payment_code': paymentCode,
        'pay_pass': payPass,
        'order_sn': orderSn,
      };
}

/// 上传图片model
class UploadImageRootModel {
  UploadImageRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory UploadImageRootModel.fromJson(Map<String, dynamic> jsonRes) =>
      UploadImageRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : UploadImageDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  UploadImageDataModel? data;
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

class UploadImageDataModel {
  UploadImageDataModel({
    this.imageUrl,
  });

  factory UploadImageDataModel.fromJson(Map<String, dynamic> jsonRes) =>
      UploadImageDataModel(
        imageUrl: asT<String?>(jsonRes['image_url']),
      );

  String? imageUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image_url': imageUrl,
      };
}

///
class ChangeAvatarRootModel {
  ChangeAvatarRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory ChangeAvatarRootModel.fromJson(Map<String, dynamic> json) =>
      ChangeAvatarRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : ChangeAvatarDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  ChangeAvatarDataModel? data;
  String msg;

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

class ChangeAvatarDataModel {
  ChangeAvatarDataModel({
    this.imgpath,
    this.memberId,
  });

  factory ChangeAvatarDataModel.fromJson(Map<String, dynamic> json) =>
      ChangeAvatarDataModel(
        imgpath: asT<String?>(json['imgPath']),
        memberId: asT<int?>(json['member_id']),
      );

  String? imgpath;
  int? memberId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'imgPath': imgpath,
        'member_id': memberId,
      };
}
