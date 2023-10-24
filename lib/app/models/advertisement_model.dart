class AdvertisementList {
  int? code;
  List<Advertisement>? data;
  int? total;
  String? detail;

  AdvertisementList({this.code, this.data, this.total, this.detail});

  AdvertisementList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Advertisement>[];
      json['data'].forEach((v) {
        data?.add(Advertisement.fromJson(v));
      });
    }
    total = json['total'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['detail'] = this.detail;
    return data;
  }
}

class Advertisement {
  int? id;
  String? name;
  String? img;
  int? pos;
  int? categoryId;
  int? type;
  String? url;
  int? goId;
  int? status;
  String? startTime;
  String? endTime;
  String? addTime;

  Advertisement(
      {this.id,
      this.name,
      this.img,
      this.pos,
      this.categoryId,
      this.type,
      this.url,
      this.goId,
      this.status,
      this.startTime,
      this.endTime,
      this.addTime});

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    pos = json['pos'];
    categoryId = json['category_id'];
    type = json['type'];
    url = json['url'];
    goId = json['go_id'];
    status = json['status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['pos'] = pos;
    data['category_id'] = categoryId;
    data['type'] = type;
    data['url'] = url;
    data['go_id'] = goId;
    data['status'] = status;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['add_time'] = addTime;
    return data;
  }
}
