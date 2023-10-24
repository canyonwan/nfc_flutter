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

class VipRootModel {
  VipRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory VipRootModel.fromJson(Map<String, dynamic> json) => VipRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : VipDataModel.fromJson(asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  VipDataModel? data;
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

class VipDataModel {
  VipDataModel({
    this.cardPrice,
    this.endTime,
    this.isVip,
    this.memberImg,
    this.memberName,
    this.startTime,
    this.vipExplain,
  });

  factory VipDataModel.fromJson(Map<String, dynamic> json) {
    final List<VipExplainModel>? vipExplain =
        json['vip_explain'] is List ? <VipExplainModel>[] : null;
    if (vipExplain != null) {
      for (final dynamic item in json['vip_explain']!) {
        if (item != null) {
          tryCatch(() {
            vipExplain.add(
                VipExplainModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return VipDataModel(
      cardPrice: asT<String?>(json['card_price']),
      endTime: asT<String?>(json['end_time']),
      isVip: asT<int?>(json['is_vip']),
      memberImg: asT<String?>(json['member_img']),
      memberName: asT<String?>(json['member_name']),
      startTime: asT<String?>(json['start_time']),
      vipExplain: vipExplain,
    );
  }

  String? cardPrice;
  String? endTime;
  int? isVip;
  String? memberImg;
  String? memberName;
  String? startTime;
  List<VipExplainModel>? vipExplain;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'card_price': cardPrice,
        'end_time': endTime,
        'is_vip': isVip,
        'member_img': memberImg,
        'member_name': memberName,
        'start_time': startTime,
        'vip_explain': vipExplain,
      };
}

class VipExplainModel {
  VipExplainModel({
    this.id,
    this.vipImage,
    this.vipTitle,
  });

  factory VipExplainModel.fromJson(Map<String, dynamic> json) =>
      VipExplainModel(
        id: asT<int?>(json['id']),
        vipImage: asT<String?>(json['vip_image']),
        vipTitle: asT<String?>(json['vip_title']),
      );

  int? id;
  String? vipImage;
  String? vipTitle;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'vip_image': vipImage,
        'vip_title': vipTitle,
      };
}
