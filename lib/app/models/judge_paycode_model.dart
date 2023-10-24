class JudgePayCodeModel {
  int? code;
  String? msg;
  Data? data;

  JudgePayCodeModel({this.code, this.msg, this.data});

  JudgePayCodeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? ifSet;

  Data({this.ifSet});

  Data.fromJson(Map<String, dynamic> json) {
    ifSet = json['if_set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['if_set'] = this.ifSet;
    return data;
  }
}
