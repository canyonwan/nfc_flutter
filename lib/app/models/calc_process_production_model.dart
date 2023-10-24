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

class CalcProcessProductionRootModel {
  CalcProcessProductionRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory CalcProcessProductionRootModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      CalcProcessProductionRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : CalcProcessProductionDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  CalcProcessProductionDataModel? data;
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

class CalcProcessProductionDataModel {
  CalcProcessProductionDataModel({
    this.totalPrice,
    this.showAddress,
    this.shipFee,
    this.describle,
  });

  factory CalcProcessProductionDataModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      CalcProcessProductionDataModel(
        totalPrice: asT<double?>(jsonRes['total_price']),
        showAddress: jsonRes['show_address'] == null
            ? null
            : AddressInfoModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['show_address'])!),
        shipFee: asT<int?>(jsonRes['ship_fee']),
        describle: asT<String?>(jsonRes['describle']),
      );

  double? totalPrice;
  AddressInfoModel? showAddress;
  int? shipFee;
  String? describle;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_price': totalPrice,
        'show_address': showAddress,
        'ship_fee': shipFee,
        'describle': describle,
      };
}

class AddressInfoModel {
  AddressInfoModel({
    this.province,
    this.memberId,
    this.isDefault,
    this.id,
    this.createTime,
    this.county,
    this.city,
    this.addressPhone,
    this.addressName,
    this.address,
  });

  factory AddressInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      AddressInfoModel(
        province: asT<String?>(jsonRes['province']),
        memberId: asT<int?>(jsonRes['member_id']),
        isDefault: asT<int?>(jsonRes['is_default']),
        id: asT<int?>(jsonRes['id']),
        createTime: asT<int?>(jsonRes['create_time']),
        county: asT<String?>(jsonRes['county']),
        city: asT<String?>(jsonRes['city']),
        addressPhone: asT<String?>(jsonRes['address_phone']),
        addressName: asT<String?>(jsonRes['address_name']),
        address: asT<String?>(jsonRes['address']),
      );

  String? province;
  int? memberId;
  int? isDefault;
  int? id;
  int? createTime;
  String? county;
  String? city;
  String? addressPhone;
  String? addressName;
  String? address;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'province': province,
        'member_id': memberId,
        'is_default': isDefault,
        'id': id,
        'create_time': createTime,
        'county': county,
        'city': city,
        'address_phone': addressPhone,
        'address_name': addressName,
        'address': address,
      };
}
