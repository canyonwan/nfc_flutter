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

class MyAddressListRootModel {
  MyAddressListRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory MyAddressListRootModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<MyAddressItem>? data =
        jsonRes['data'] is List ? <MyAddressItem>[] : null;
    if (data != null) {
      for (final dynamic item in jsonRes['data']!) {
        if (item != null) {
          tryCatch(() {
            data.add(MyAddressItem.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return MyAddressListRootModel(
      msg: asT<String?>(jsonRes['msg']),
      data: data,
      code: asT<int?>(jsonRes['code']),
    );
  }

  String? msg;
  List<MyAddressItem>? data;
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

class MyAddressItem {
  MyAddressItem({
    this.province,
    this.memberId,
    this.isDefault,
    this.id,
    this.addressId,
    this.createTime,
    this.county,
    this.city,
    this.addressPhone,
    this.addressName,
    this.address,
  });

  factory MyAddressItem.fromJson(Map<String, dynamic> jsonRes) => MyAddressItem(
        province: asT<String?>(jsonRes['province']),
        memberId: asT<int?>(jsonRes['member_id']),
        isDefault: asT<int?>(jsonRes['is_default']),
        id: asT<int?>(jsonRes['id']),
        addressId: asT<int?>(jsonRes['address_id']),
        createTime: asT<String?>(jsonRes['create_time']),
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
  String? createTime;
  String? county;
  String? city;
  String? addressPhone;
  String? addressName;
  int? addressId;
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
        'address_id': addressId,
        'create_time': createTime,
        'county': county,
        'city': city,
        'address_phone': addressPhone,
        'address_name': addressName,
        'address': address,
      };
}
