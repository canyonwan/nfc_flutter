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

class BalanceRootModel {
  BalanceRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BalanceRootModel.fromJson(Map<String, dynamic> json) =>
      BalanceRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : BalanceDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  BalanceDataModel? data;
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

class BalanceDataModel {
  BalanceDataModel({
    this.balance,
    this.list,
    this.maxpage,
  });

  factory BalanceDataModel.fromJson(Map<String, dynamic> json) {
    final List<BalanceItemModel>? list =
        json['list'] is List ? <BalanceItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(
                BalanceItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return BalanceDataModel(
      balance: asT<String?>(json['balance']),
      list: list,
      maxpage: asT<int?>(json['maxPage']),
    );
  }

  String? balance;
  List<BalanceItemModel>? list;
  int? maxpage;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'balance': balance,
        'list': list,
        'maxPage': maxpage,
      };
}

class BalanceItemModel {
  BalanceItemModel({
    this.createtime,
    this.describe,
    this.id,
    this.memberId,
    this.price,
    this.type,
  });

  factory BalanceItemModel.fromJson(Map<String, dynamic> json) =>
      BalanceItemModel(
        createtime: asT<String?>(json['createtime']),
        describe: asT<String?>(json['describe']),
        id: asT<int?>(json['id']),
        memberId: asT<int?>(json['member_id']),
        price: asT<String?>(json['price']),
        type: asT<int?>(json['type']),
      );

  String? createtime;
  String? describe;
  int? id;
  int? memberId;
  String? price;
  int? type;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'createtime': createtime,
        'describe': describe,
        'id': id,
        'member_id': memberId,
        'price': price,
        'type': type,
      };
}

/// 充值卡使用记录
class BalanceCardUseListRootModel {
  BalanceCardUseListRootModel({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BalanceCardUseListRootModel.fromJson(Map<String, dynamic> json) =>
      BalanceCardUseListRootModel(
        code: asT<int>(json['code'])!,
        data: json['data'] == null
            ? null
            : BalanceCardUseListDataModel.fromJson(
                asT<Map<String, dynamic>>(json['data'])!),
        msg: asT<String>(json['msg'])!,
      );

  int code;
  BalanceCardUseListDataModel? data;
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

class BalanceCardUseListDataModel {
  BalanceCardUseListDataModel({
    this.cardBalance,
  });

  factory BalanceCardUseListDataModel.fromJson(Map<String, dynamic> json) {
    final List<CardBalanceItemModel>? cardBalance =
        json['card_balance'] is List ? <CardBalanceItemModel>[] : null;
    if (cardBalance != null) {
      for (final dynamic item in json['card_balance']!) {
        if (item != null) {
          tryCatch(() {
            cardBalance.add(CardBalanceItemModel.fromJson(
                asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return BalanceCardUseListDataModel(
      cardBalance: cardBalance,
    );
  }

  List<CardBalanceItemModel>? cardBalance;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'card_balance': cardBalance,
      };
}

class CardBalanceItemModel {
  CardBalanceItemModel({
    this.id,
    this.number,
    this.price,
    this.useTime,
  });

  factory CardBalanceItemModel.fromJson(Map<String, dynamic> json) =>
      CardBalanceItemModel(
        id: asT<int?>(json['id']),
        number: asT<String?>(json['number']),
        price: asT<String?>(json['price']),
        useTime: asT<String?>(json['use_time']),
      );

  int? id;
  String? number;
  String? price;
  String? useTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'number': number,
        'price': price,
        'use_time': useTime,
      };
}
