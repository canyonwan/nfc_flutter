import 'dart:convert';

class OrderFirmProduct {
  int? productId;
  int? skuId;
  String? productPic;
  String? productName;
  int? quantity;
  String? attr;
  double? price;

  OrderFirmProduct({
    this.productId,
    this.skuId,
    this.productPic,
    this.productName,
    this.quantity,
    this.attr,
    this.price,
  });

  OrderFirmProduct.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    skuId = json["sku_id"];
    productPic = json["product_pic"];
    productName = json["product_name"];
    quantity = json["quantity"];
    if (json["attr"] != null) {
      List<String> list = [];
      List attrList = jsonDecode(json["attr"]);
      attrList.forEach((v) {
        list.add(v["value"]!);
      });
      attr = list.join("/");
    }
    price = json["price"] + 0.00;
  }
}

class OrderFirmResponse {
  int code;
  List<OrderFirmProduct>? data;
  String detail;

  OrderFirmResponse({required this.code, this.data, required this.detail});

  factory OrderFirmResponse.fromJson(Map<String, dynamic> json) {
    int code = json["code"];
    String detail = json["detail"];

    List<OrderFirmProduct> list = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        list.add(OrderFirmProduct.fromJson(v));
      });
    }
    return OrderFirmResponse(code: code, detail: detail, data: list);
  }
}
