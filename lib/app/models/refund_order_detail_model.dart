import 'dart:convert';
import 'dart:developer';

import 'order_detail_model.dart';

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

class RefundOrderDetailRootModel {
  RefundOrderDetailRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory RefundOrderDetailRootModel.fromJson(Map<String, dynamic> json) =>
      RefundOrderDetailRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : RefundOrderDetailDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  RefundOrderDetailDataModel? data;
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

class RefundOrderDetailDataModel {
  RefundOrderDetailDataModel({
    this.deliveryName,
    this.deliveryPhone,
    this.expressName,
    this.expressNum,
    this.goodsList,
    this.orderSn,
    this.orderTimeList,
    this.refundTime,
    this.remark,
    this.returnPrice,
    this.shouldReturnPrice,
    this.zhuangtai,
  });

  factory RefundOrderDetailDataModel.fromJson(Map<String, dynamic> json) {
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
    return RefundOrderDetailDataModel(
      deliveryName: asT<String?>(json['delivery_name']),
      deliveryPhone: asT<String?>(json['delivery_phone']),
      expressName: asT<String?>(json['express_name']),
      expressNum: asT<String?>(json['express_num']),
      goodsList: goodsList,
      orderSn: asT<String?>(json['order_sn']),
      orderTimeList: orderTimeList,
      refundTime: asT<String?>(json['refund_time']),
      remark: asT<String?>(json['remark']),
      returnPrice: asT<int?>(json['return_price']),
      shouldReturnPrice: asT<String?>(json['should_return_price']),
      zhuangtai: asT<String?>(json['zhuangtai']),
    );
  }

  String? deliveryName;
  String? deliveryPhone;
  String? expressName;
  String? expressNum;
  List<GoodsItemModel>? goodsList;
  String? orderSn;
  List<OrderTimelineModel>? orderTimeList;
  String? refundTime;
  String? remark;
  int? returnPrice;
  String? shouldReturnPrice;
  String? zhuangtai;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'delivery_name': deliveryName,
        'delivery_phone': deliveryPhone,
        'express_name': expressName,
        'express_num': expressNum,
        'goods_list': goodsList,
        'order_sn': orderSn,
        'order_time_list': orderTimeList,
        'refund_time': refundTime,
        'remark': remark,
        'return_price': returnPrice,
        'should_return_price': shouldReturnPrice,
        'zhuangtai': zhuangtai,
      };
}
