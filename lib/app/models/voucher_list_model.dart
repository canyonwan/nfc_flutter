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

class VoucherListRootModel {
  VoucherListRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory VoucherListRootModel.fromJson(Map<String, dynamic> json) =>
      VoucherListRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : VoucherListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  VoucherListDataModel? data;
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

class VoucherListDataModel {
  VoucherListDataModel({
    this.voucherDetail,
  });

  factory VoucherListDataModel.fromJson(Map<String, dynamic> json) {
    final List<VoucherItemModel>? voucherDetail =
        json['voucher_detail'] is List ? <VoucherItemModel>[] : null;
    if (voucherDetail != null) {
      for (final dynamic item in json['voucher_detail']!) {
        if (item != null) {
          tryCatch(() {
            voucherDetail.add(
                VoucherItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return VoucherListDataModel(
      voucherDetail: voucherDetail,
    );
  }

  List<VoucherItemModel>? voucherDetail;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'voucher_detail': voucherDetail,
      };
}

class VoucherItemModel {
  VoucherItemModel({
    this.amount,
    this.createtime,
    this.endTime,
    this.explain,
    this.full,
    this.getNum,
    this.id,
    this.name,
    this.price,
    this.residueNum,
    this.startTime,
    this.useTime,
  });

  factory VoucherItemModel.fromJson(Map<String, dynamic> json) =>
      VoucherItemModel(
        amount: asT<int?>(json['amount']),
        createtime: asT<int?>(json['createtime']),
        endTime: asT<String?>(json['end_time']),
        explain: asT<String?>(json['explain']),
        full: asT<String?>(json['full']),
        getNum: asT<int?>(json['get_num']),
        id: asT<int?>(json['id']),
        name: asT<String?>(json['name']),
        price: asT<String?>(json['price']),
        residueNum: asT<int?>(json['residue_num']),
        startTime: asT<String?>(json['start_time']),
        useTime: asT<String?>(json['use_time']),
      );

  int? amount;
  int? createtime;
  String? endTime;
  String? explain;
  String? full;
  int? getNum;
  int? id;
  String? name;
  String? price;
  int? residueNum;
  String? startTime;
  String? useTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'createtime': createtime,
        'end_time': endTime,
        'explain': explain,
        'full': full,
        'get_num': getNum,
        'id': id,
        'name': name,
        'price': price,
        'residue_num': residueNum,
        'start_time': startTime,
        'use_time': useTime,
      };
}
