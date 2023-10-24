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

class OrderDetailRootModel {
  OrderDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory OrderDetailRootModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : OrderDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  OrderDetailDataModel? data;
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

class OrderDetailDataModel {
  OrderDetailDataModel({
    this.address,
    this.addressDetail,
    this.addressId,
    this.addressName,
    this.addressPhone,
    this.city,
    this.consume,
    this.county,
    this.createTime,
    this.deliveryId,
    this.deliveryName,
    this.deliveryPhone,
    this.distributionState,
    this.distributionType,
    this.expirationTime,
    this.expressName,
    this.expressNum,
    this.goodsList,
    this.granaryId,
    this.granaryType,
    this.id,
    this.ifGranary,
    this.ifPresell,
    this.isGiftCard,
    this.isShow,
    this.isSince,
    this.memberId,
    this.memberVoucherId,
    this.noutoasiakasId,
    this.orderAmount,
    this.orderSn,
    this.orderState,
    this.orderTimeList,
    this.originalPrice,
    this.paymentCode,
    this.paymentId,
    this.paymentNum,
    this.paymentTime,
    this.province,
    this.reason,
    this.remark,
    this.savePrice,
    this.sellerId,
    this.shipFee,
    this.status,
    this.tableNumber,
    this.totalGoodsPrice,
    this.trackingId,
    this.trackingNumber,
    this.voucherPrice,
    this.zhuangtai,
  });

  factory OrderDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<GoodsItemModel>? goodsList =
        json['goods_list'] is List ? <GoodsItemModel>[] : null;
    if (goodsList != null) {
      for (final dynamic item in json['goods_list']!) {
        if (item != null) {
          tryCatch(() {
            goodsList
                .add(GoodsItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<OrderTimelineModel>? orderTimeList =
        json['order_time_list'] is List ? <OrderTimelineModel>[] : null;
    if (orderTimeList != null) {
      for (final dynamic item in json['order_time_list']!) {
        if (item != null) {
          tryCatch(() {
            orderTimeList.add(
                OrderTimelineModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return OrderDetailDataModel(
      address: asT<String?>(json['address']),
      addressDetail: json['address_detail'] == null
          ? null
          : AddressDetailModel.fromJson(
              asT<Map<String, dynamic>>(json['address_detail'])!),
      addressId: asT<int?>(json['address_id']),
      addressName: asT<String?>(json['address_name']),
      addressPhone: asT<String?>(json['address_phone']),
      city: asT<String?>(json['city']),
      consume: asT<int?>(json['consume']),
      county: asT<String?>(json['county']),
      createTime: asT<String?>(json['create_time']),
      deliveryId: asT<Object?>(json['delivery_id']),
      deliveryName: asT<String?>(json['delivery_name']),
      deliveryPhone: asT<String?>(json['delivery_phone']),
      distributionState: asT<int?>(json['distribution_state']),
      distributionType: asT<int?>(json['distribution_type']),
      expirationTime: asT<int?>(json['expiration_time']),
      expressName: asT<String?>(json['express_name']),
      expressNum: asT<String?>(json['express_num']),
      goodsList: goodsList,
      granaryId: asT<Object?>(json['granary_id']),
      granaryType: asT<int?>(json['granary_type']),
      id: asT<int?>(json['id']),
      ifGranary: asT<int?>(json['if_granary']),
      ifPresell: asT<int?>(json['if_presell']),
      isGiftCard: asT<int?>(json['is_gift_card']),
      isShow: asT<int?>(json['is_show']),
      isSince: asT<int?>(json['is_since']),
      memberId: asT<int?>(json['member_id']),
      memberVoucherId: asT<int?>(json['member_voucher_id']),
      noutoasiakasId: asT<Object?>(json['noutoasiakas_id']),
      orderAmount: asT<String?>(json['order_amount']),
      orderSn: asT<String?>(json['order_sn']),
      orderState: asT<String?>(json['order_state']),
      orderTimeList: orderTimeList,
      originalPrice: asT<String?>(json['original_price']),
      paymentCode: asT<String?>(json['payment_code']),
      paymentId: asT<int?>(json['payment_id']),
      paymentNum: asT<String?>(json['payment_num']),
      paymentTime: asT<int?>(json['payment_time']),
      province: asT<String?>(json['province']),
      reason: asT<Object?>(json['reason']),
      remark: asT<String?>(json['remark']),
      savePrice: asT<String?>(json['save_price']),
      sellerId: asT<int?>(json['seller_id']),
      shipFee: asT<String?>(json['ship_fee']),
      status: asT<int?>(json['status']),
      tableNumber: asT<int?>(json['table_number']),
      totalGoodsPrice: asT<String?>(json['total_goods_price']),
      trackingId: asT<int?>(json['tracking_id']),
      trackingNumber: asT<String?>(json['tracking_number']),
      voucherPrice: asT<String?>(json['voucher_price']),
      zhuangtai: asT<String?>(json['zhuangtai']),
    );
  }

  String? address;
  AddressDetailModel? addressDetail;
  int? addressId;
  String? addressName;
  String? addressPhone;
  String? city;
  int? consume;
  String? county;
  String? createTime;
  Object? deliveryId;
  String? deliveryName;
  String? deliveryPhone;
  int? distributionState;
  int? distributionType;
  int? expirationTime;
  String? expressName;
  String? expressNum;
  List<GoodsItemModel>? goodsList;
  Object? granaryId;
  int? granaryType;
  int? id;
  int? ifGranary;
  int? ifPresell;
  int? isGiftCard;
  int? isShow;
  int? isSince;
  int? memberId;
  int? memberVoucherId;
  Object? noutoasiakasId;
  String? orderAmount;
  String? orderSn;
  String? orderState;
  List<OrderTimelineModel>? orderTimeList;
  String? originalPrice;
  String? paymentCode;
  int? paymentId;
  String? paymentNum;
  int? paymentTime;
  String? province;
  Object? reason;
  String? remark;
  String? savePrice;
  int? sellerId;
  String? shipFee;
  int? status;
  int? tableNumber;
  String? totalGoodsPrice;
  int? trackingId;
  String? trackingNumber;
  String? voucherPrice;
  String? zhuangtai;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'address_detail': addressDetail,
        'address_id': addressId,
        'address_name': addressName,
        'address_phone': addressPhone,
        'city': city,
        'consume': consume,
        'county': county,
        'create_time': createTime,
        'delivery_id': deliveryId,
        'delivery_name': deliveryName,
        'delivery_phone': deliveryPhone,
        'distribution_state': distributionState,
        'distribution_type': distributionType,
        'expiration_time': expirationTime,
        'express_name': expressName,
        'express_num': expressNum,
        'goods_list': goodsList,
        'granary_id': granaryId,
        'granary_type': granaryType,
        'id': id,
        'if_granary': ifGranary,
        'if_presell': ifPresell,
        'is_gift_card': isGiftCard,
        'is_show': isShow,
        'is_since': isSince,
        'member_id': memberId,
        'member_voucher_id': memberVoucherId,
        'noutoasiakas_id': noutoasiakasId,
        'order_amount': orderAmount,
        'order_sn': orderSn,
        'order_state': orderState,
        'order_time_list': orderTimeList,
        'original_price': originalPrice,
        'payment_code': paymentCode,
        'payment_id': paymentId,
        'payment_num': paymentNum,
        'payment_time': paymentTime,
        'province': province,
        'reason': reason,
        'remark': remark,
        'save_price': savePrice,
        'seller_id': sellerId,
        'ship_fee': shipFee,
        'status': status,
        'table_number': tableNumber,
        'total_goods_price': totalGoodsPrice,
        'tracking_id': trackingId,
        'tracking_number': trackingNumber,
        'voucher_price': voucherPrice,
        'zhuangtai': zhuangtai,
      };
}

class AddressDetailModel {
  AddressDetailModel({
    this.address,
    this.addressName,
    this.addressPhone,
    this.city,
    this.county,
    this.province,
  });

  factory AddressDetailModel.fromJson(Map<String, dynamic> json) =>
      AddressDetailModel(
        address: asT<String?>(json['address']),
        addressName: asT<String?>(json['address_name']),
        addressPhone: asT<String?>(json['address_phone']),
        city: asT<String?>(json['city']),
        county: asT<String?>(json['county']),
        province: asT<String?>(json['province']),
      );

  String? address;
  String? addressName;
  String? addressPhone;
  String? city;
  String? county;
  String? province;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'address_name': addressName,
        'address_phone': addressPhone,
        'city': city,
        'county': county,
        'province': province,
      };
}

class GoodsItemModel {
  GoodsItemModel({
    this.goodsFormat,
    this.goodsId,
    this.goodsName,
    this.goodsNum,
    this.goodsPrice,
    this.id,
    this.image,
    this.isEvaluation,
    this.memberId,
    this.memberName,
    this.orderId,
    this.paymentNum,
    this.type,
  });

  factory GoodsItemModel.fromJson(Map<String, dynamic> json) => GoodsItemModel(
        goodsFormat: asT<String?>(json['goods_format']),
        goodsId: asT<int?>(json['goods_id']),
        goodsName: asT<String?>(json['goods_name']),
        goodsNum: asT<String?>(json['goods_num']),
        goodsPrice: asT<String?>(json['goods_price']),
        id: asT<int?>(json['id']),
        image: asT<String?>(json['image']),
        isEvaluation: asT<int?>(json['is_evaluation']),
        memberId: asT<int?>(json['member_id']),
        memberName: asT<String?>(json['member_name']),
        orderId: asT<int?>(json['order_id']),
        paymentNum: asT<String?>(json['payment_num']),
        type: asT<Object?>(json['type']),
      );

  String? goodsFormat;
  int? goodsId;
  String? goodsName;
  String? goodsNum;
  String? goodsPrice;
  int? id;
  String? image;
  int? isEvaluation;
  int? memberId;
  String? memberName;
  int? orderId;
  String? paymentNum;
  Object? type;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'goods_format': goodsFormat,
        'goods_id': goodsId,
        'goods_name': goodsName,
        'goods_num': goodsNum,
        'goods_price': goodsPrice,
        'id': id,
        'image': image,
        'is_evaluation': isEvaluation,
        'member_id': memberId,
        'member_name': memberName,
        'order_id': orderId,
        'payment_num': paymentNum,
        'type': type,
      };
}

class OrderTimelineModel {
  OrderTimelineModel({
    this.acceptstation,
    this.accepttime,
  });

  factory OrderTimelineModel.fromJson(Map<String, dynamic> json) =>
      OrderTimelineModel(
        acceptstation: asT<String?>(json['AcceptStation']),
        accepttime: asT<String?>(json['AcceptTime']),
      );

  String? acceptstation;
  String? accepttime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'AcceptStation': acceptstation,
        'AcceptTime': accepttime,
      };
}
