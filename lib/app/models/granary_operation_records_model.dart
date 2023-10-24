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

class GranaryOperationRecordsRootModel {
  GranaryOperationRecordsRootModel({
    this.msg,
    this.data,
    this.code,
  });

  factory GranaryOperationRecordsRootModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      GranaryOperationRecordsRootModel(
        msg: asT<String?>(jsonRes['msg']),
        data: jsonRes['data'] == null
            ? null
            : GranaryOperationRecordsDataModel.fromJson(
                asT<Map<String, dynamic>>(jsonRes['data'])!),
        code: asT<int?>(jsonRes['code']),
      );

  String? msg;
  GranaryOperationRecordsDataModel? data;
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

class GranaryOperationRecordsDataModel {
  GranaryOperationRecordsDataModel({
    this.totalPage,
    this.recordList,
  });

  factory GranaryOperationRecordsDataModel.fromJson(
      Map<String, dynamic> jsonRes) {
    final List<RecordListItemModel>? recordList =
        jsonRes['record_list'] is List ? <RecordListItemModel>[] : null;
    if (recordList != null) {
      for (final dynamic item in jsonRes['record_list']!) {
        if (item != null) {
          tryCatch(() {
            recordList.add(
                RecordListItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return GranaryOperationRecordsDataModel(
      totalPage: asT<int?>(jsonRes['total_page']),
      recordList: recordList,
    );
  }

  int? totalPage;
  List<RecordListItemModel>? recordList;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total_page': totalPage,
        'record_list': recordList,
      };
}

class RecordListItemModel {
  RecordListItemModel({
    this.name,
    this.list,
  });

  factory RecordListItemModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<RecordItemModel>? list =
        jsonRes['list'] is List ? <RecordItemModel>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(
                RecordItemModel.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return RecordListItemModel(
      name: asT<String?>(jsonRes['name']),
      list: list,
    );
  }

  String? name;
  List<RecordItemModel>? list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'list': list,
      };
}

class RecordItemModel {
  RecordItemModel({
    this.status,
    this.num,
    this.id,
    this.createtime,
  });

  factory RecordItemModel.fromJson(Map<String, dynamic> jsonRes) =>
      RecordItemModel(
        status: asT<String?>(jsonRes['status']),
        num: asT<String?>(jsonRes['num']),
        id: asT<int?>(jsonRes['id']),
        createtime: asT<String?>(jsonRes['createtime']),
      );

  String? status;
  String? num;
  int? id;
  String? createtime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'num': num,
        'id': id,
        'createtime': createtime,
      };
}
