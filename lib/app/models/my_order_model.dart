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

class MyOrderRootModel {
  MyOrderRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory MyOrderRootModel.fromJson(Map<String, dynamic> json) =>
      MyOrderRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : MyOrderDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  MyOrderDataModel? data;
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

class MyOrderDataModel {
  MyOrderDataModel({
    this.orderList,
    required this.totalPage,
  });

  factory MyOrderDataModel.fromJson(Map<String, dynamic> json) {
    final List<OrderItemModel>? orderList =
        json['order_list'] is List ? <OrderItemModel>[] : null;
    if (orderList != null) {
      for (final dynamic item in json['order_list']!) {
        if (item != null) {
          tryCatch(() {
            orderList
                .add(OrderItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return MyOrderDataModel(
      orderList: orderList,
      totalPage: asT<int>(json['total_page'])!,
    );
  }

  List<OrderItemModel>? orderList;
  int totalPage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order_list': orderList,
        'total_page': totalPage,
      };
}

class OrderItemModel {
  OrderItemModel({
    this.createTime,
    this.goodsList,
    this.id,
    this.ifPresell,
    this.isCancel,
    this.isDelete,
    this.isDetail,
    this.isLogistics,
    this.isPay,
    this.isReceipt,
    this.isRefund,
    this.orderAmount,
    this.orderSn,
    this.orderState,
    this.paymentNum,
    this.status,
    this.title,
    this.totalGoodsNum,
    this.zhuangtai,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
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
    return OrderItemModel(
      createTime: asT<String?>(json['create_time']),
      goodsList: goodsList,
      id: asT<int?>(json['id']),
      ifPresell: asT<int?>(json['if_presell']),
      isCancel: asT<int?>(json['is_cancel']),
      isDelete: asT<int?>(json['is_delete']),
      isDetail: asT<int?>(json['is_detail']),
      isLogistics: asT<int?>(json['is_logistics']),
      isPay: asT<int?>(json['is_pay']),
      isReceipt: asT<int?>(json['is_receipt']),
      isRefund: asT<int?>(json['is_refund']),
      orderAmount: asT<String?>(json['order_amount']),
      orderSn: asT<String?>(json['order_sn']),
      orderState: asT<String?>(json['order_state']),
      paymentNum: asT<String?>(json['payment_num']),
      status: asT<int?>(json['status']),
      title: asT<String?>(json['title']),
      totalGoodsNum: asT<int?>(json['total_goods_num']),
      zhuangtai: asT<String?>(json['zhuangtai']),
    );
  }

  String? createTime;
  List<GoodsItemModel>? goodsList;
  int? id;
  int? ifPresell;
  int? isCancel;
  int? isDelete;
  int? isDetail;
  int? isLogistics;
  int? isPay;
  int? isReceipt;
  int? isRefund;
  String? orderAmount;
  String? orderSn;
  String? orderState;
  String? paymentNum;
  int? status;
  String? title;
  int? totalGoodsNum;
  String? zhuangtai;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'create_time': createTime,
        'goods_list': goodsList,
        'id': id,
        'if_presell': ifPresell,
        'is_cancel': isCancel,
        'is_delete': isDelete,
        'is_detail': isDetail,
        'is_logistics': isLogistics,
        'is_pay': isPay,
        'is_receipt': isReceipt,
        'is_refund': isRefund,
        'order_amount': orderAmount,
        'order_sn': orderSn,
        'order_state': orderState,
        'payment_num': paymentNum,
        'status': status,
        'title': title,
        'total_goods_num': totalGoodsNum,
        'zhuangtai': zhuangtai,
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
    this.isEvaluate,
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
        isEvaluate: asT<int?>(json['is_evaluate']),
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
  int? isEvaluate;
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
        'is_evaluate': isEvaluate,
        'is_evaluation': isEvaluation,
        'member_id': memberId,
        'member_name': memberName,
        'order_id': orderId,
        'payment_num': paymentNum,
        'type': type,
      };
}
