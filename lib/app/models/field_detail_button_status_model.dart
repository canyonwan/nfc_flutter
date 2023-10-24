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

class FieldDetailButtonStatusRootModel {
  FieldDetailButtonStatusRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory FieldDetailButtonStatusRootModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      FieldDetailButtonStatusRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : FieldDetailButtonStatusDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  FieldDetailButtonStatusDataModel? data;
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

class FieldDetailButtonStatusDataModel {
  FieldDetailButtonStatusDataModel({
    this.vrList,
    this.status,
    this.monitorToken,
    this.monitorAddress2,
    this.liveAddress,
    this.ifVr,
    this.ifUpload,
    this.ifVideo,
    this.ifMonitor2,
    this.ifLike,
  });

  factory FieldDetailButtonStatusDataModel.fromJson(
      Map<String, dynamic> jsonRes) {
    final List<VRItemModel>? vrList =
        jsonRes['vr_list'] is List ? <VRItemModel>[] : null;
    if (vrList != null) {
      for (final dynamic item in jsonRes['vr_list']!) {
        if (item != null) {
          tryCatch(() {
            vrList.add(VRItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<MonitorModel>? monitorAddress2 =
        jsonRes['monitor_address2'] is List ? <MonitorModel>[] : null;
    if (monitorAddress2 != null) {
      for (final dynamic item in jsonRes['monitor_address2']!) {
        if (item != null) {
          tryCatch(() {
            monitorAddress2
                .add(MonitorModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return FieldDetailButtonStatusDataModel(
      vrList: vrList,
      status: asT<int?>(jsonRes['status']),
      monitorToken: asT<String?>(jsonRes['monitor_token']),
      monitorAddress2: monitorAddress2,
      liveAddress: asT<String?>(jsonRes['live_address']),
      ifVr: asT<int?>(jsonRes['if_vr']),
      ifUpload: asT<int?>(jsonRes['if_upload']),
      ifVideo: asT<int?>(jsonRes['if_video']),
      ifMonitor2: asT<int?>(jsonRes['if_monitor2']),
      ifLike: asT<int?>(jsonRes['if_like']),
    );
  }

  List<VRItemModel>? vrList;
  int? status;
  String? monitorToken;
  List<MonitorModel>? monitorAddress2;
  String? liveAddress;
  int? ifVr;
  int? ifUpload;
  int? ifVideo;
  int? ifMonitor2;
  int? ifLike;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'vr_list': vrList,
        'status': status,
        'monitor_token': monitorToken,
        'monitor_address2': monitorAddress2,
        'live_address': liveAddress,
        'if_vr': ifVr,
        'if_upload': ifUpload,
        'if_video': ifVideo,
        'if_monitor2': ifMonitor2,
        'if_like': ifLike,
      };
}

class MonitorModel {
  MonitorModel({
    this.url,
    this.number,
    this.name,
    this.image,
    this.channels,
  });

  factory MonitorModel.fromJson(Map<String, dynamic> jsonRes) => MonitorModel(
        url: asT<String?>(jsonRes['url']),
        number: asT<String?>(jsonRes['number']),
        name: asT<String?>(jsonRes['name']),
        image: asT<String?>(jsonRes['image']),
        channels: asT<String?>(jsonRes['channels']),
      );

  String? url;
  String? number;
  String? name;
  String? image;
  String? channels;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'number': number,
        'name': name,
        'image': image,
        'channels': channels,
      };
}

class VRItemModel {
  VRItemModel({
    this.tactic,
    this.status,
    this.name,
    this.image,
    this.id,
    this.creattime,
    this.articlesId,
  });

  factory VRItemModel.fromJson(Map<String, dynamic> jsonRes) => VRItemModel(
        tactic: asT<int?>(jsonRes['tactic']),
        status: asT<int?>(jsonRes['status']),
        name: asT<String?>(jsonRes['name']),
        image: asT<String?>(jsonRes['image']),
        id: asT<int?>(jsonRes['id']),
        creattime: asT<String?>(jsonRes['creattime']),
        articlesId: asT<int?>(jsonRes['articles_id']),
      );

  int? tactic;
  int? status;
  String? name;
  String? image;
  int? id;
  String? creattime;
  int? articlesId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tactic': tactic,
        'status': status,
        'name': name,
        'image': image,
        'id': id,
        'creattime': creattime,
        'articles_id': articlesId,
      };
}

/// 生成田地认领订单/
class CreateFieldClaimRootModel {
  CreateFieldClaimRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory CreateFieldClaimRootModel.fromJson(Map<String, dynamic> json) =>
      CreateFieldClaimRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : CreateFieldClaimDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  CreateFieldClaimDataModel? data;
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

class CreateFieldClaimDataModel {
  CreateFieldClaimDataModel({
    this.orderSn,
    this.totalPrice,
  });

  factory CreateFieldClaimDataModel.fromJson(Map<String, dynamic> json) =>
      CreateFieldClaimDataModel(
        orderSn: asT<String?>(json['order_sn']),
        totalPrice: asT<double?>(json['total_price']),
      );

  String? orderSn;
  double? totalPrice;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order_sn': orderSn,
        'total_price': totalPrice,
      };
}
