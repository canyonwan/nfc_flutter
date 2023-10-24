class ProductList {
  int? code;
  List<Product>? product;
  String? detail;
  int? total;

  ProductList({this.code, this.product, this.detail, this.total});

  ProductList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      product = <Product>[];
      json['data'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    detail = json['detail'];
    total = json['total'];
  }
}

class ProductInfo {
  int? code;
  Product? product;
  String? detail;

  ProductInfo({this.code, this.product, this.detail});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    product = json['data'] != null ? Product.fromJson(json['data']) : null;
    detail = json['detail'];
  }
}

class Product {
  int? id;
  int? brandId;
  int? productCategoryId;
  int? feightTemplateId;
  int? productAttributeCategoryId;
  String? productSn;
  int? deleteStatus;
  int? publishStatus;
  int? newStatus;
  int? recommendStatus;
  int? verifyStatus;
  int? sort;
  int? sale;
  double? price;
  double? promotionPrice;
  int? giftGrowth;
  int? giftPoint;
  int? usePointLimit;
  double? originalPrice;
  int? stock;
  int? lowStock;
  String? unit;
  double? weight;
  int? previewStatus;
  String? serviceIds;
  String? pic;
  String? albumPics;
  String? promotionStartTime;
  String? promotionEndTime;
  int? promotionPerLimit;
  int? promotionType;
  String? language;
  String? name;
  String? subTitle;
  String? description;
  String? keywords;
  String? note;
  String? detailTitle;
  String? detailDesc;
  String? detailHtml;
  String? detailMobileHtml;
  String? productCategoryName;
  String? brandName;
  int? comment_number;
  List<SkuStock>? skuStock;
  List<ProductLadder>? productLadder;
  List<ProductFullReduction>? productFullReduction;
  List<ProductAttrValue>? productAttrValue;
  List<MemberPrice>? memberPrice;
  List<ProductAttribute>? productAttribute;
  List<Parameters>? parameters;

  Product({
    this.id,
    this.brandId,
    this.productCategoryId,
    this.feightTemplateId,
    this.productAttributeCategoryId,
    this.productSn,
    this.deleteStatus,
    this.publishStatus,
    this.newStatus,
    this.recommendStatus,
    this.verifyStatus,
    this.sort,
    this.sale,
    this.price,
    this.promotionPrice,
    this.giftGrowth,
    this.giftPoint,
    this.usePointLimit,
    this.originalPrice,
    this.stock,
    this.lowStock,
    this.unit,
    this.weight,
    this.previewStatus,
    this.serviceIds,
    this.pic,
    this.albumPics,
    this.promotionStartTime,
    this.promotionEndTime,
    this.promotionPerLimit,
    this.promotionType,
    this.language,
    this.name,
    this.subTitle,
    this.description,
    this.keywords,
    this.note,
    this.detailTitle,
    this.detailDesc,
    this.detailHtml,
    this.detailMobileHtml,
    this.productCategoryName,
    this.brandName,
    this.skuStock,
    this.productLadder,
    this.productFullReduction,
    this.productAttrValue,
    this.memberPrice,
    this.productAttribute,
    this.parameters,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brand_id'];
    productCategoryId = json['product_category_id'];
    feightTemplateId = json['feight_template_id'];
    productAttributeCategoryId = json['product_attribute_category_id'];
    productSn = json['product_sn'];
    deleteStatus = json['delete_status'];
    publishStatus = json['publish_status'];
    newStatus = json['new_status'];
    recommendStatus = json['recommend_status'];
    verifyStatus = json['verify_status'];
    sort = json['sort'];
    sale = json['sale'];
    price = json['price'] + 0.00;
    promotionPrice = json['promotion_price'] + 0.00;
    giftGrowth = json['gift_growth'];
    giftPoint = json['gift_point'];
    usePointLimit = json['use_point_limit'];
    originalPrice = json['original_price'] + 0.00;
    stock = json['stock'];
    lowStock = json['low_stock'];
    unit = json['unit'];
    weight = json['weight'] + 0.00;
    previewStatus = json['preview_status'];
    serviceIds = json['service_ids'];
    pic = json['pic'];
    albumPics = json['album_pics'];
    promotionStartTime = json['promotion_start_time'];
    promotionEndTime = json['promotion_end_time'];
    promotionPerLimit = json['promotion_per_limit'];
    promotionType = json['promotion_type'];
    language = json['language'];
    name = json['name'];
    subTitle = json['sub_title'];
    description = json['description'];
    keywords = json['keywords'];
    note = json['note'];
    detailTitle = json['detail_title'];
    detailDesc = json['detail_desc'];
    detailHtml = json['detail_html'];
    detailMobileHtml = json['detail_mobile_html'];
    productCategoryName = json['product_category_name'];
    comment_number = json["comment_number"];
    brandName = json['brand_name'];
    if (json['sku_stock'] != null) {
      skuStock = <SkuStock>[];
      json['sku_stock'].forEach((v) {
        skuStock!.add(new SkuStock.fromJson(v));
      });
    }
    if (json['product_ladder'] != null) {
      productLadder = <ProductLadder>[];
      json['product_ladder'].forEach((v) {
        productLadder!.add(new ProductLadder.fromJson(v));
      });
    }
    if (json['product_full_reduction'] != null) {
      productFullReduction = <ProductFullReduction>[];
      json['product_full_reduction'].forEach((v) {
        productFullReduction!.add(new ProductFullReduction.fromJson(v));
      });
    }
    if (json['product_attr_value'] != null) {
      productAttrValue = <ProductAttrValue>[];
      json['product_attr_value'].forEach((v) {
        productAttrValue!.add(new ProductAttrValue.fromJson(v));
      });
    }
    if (json['member_price'] != null) {
      memberPrice = <MemberPrice>[];
      json['member_price']
          .forEach((v) => {memberPrice!.add(MemberPrice.fromJson(v))});
    }

    if (json['product_attribute'] != null) {
      productAttribute = <ProductAttribute>[];
      json['product_attribute'].forEach((v) {
        productAttribute!.add(new ProductAttribute.fromJson(v));
      });
    }

    if (json["parameters"] != null) {
      parameters = <Parameters>[];
      json["parameters"].forEach((v) {
        parameters!.add(new Parameters.fromJson(v));
      });
    }
  }
}

class SkuStock {
  int? id;
  int? productId;
  String? skuCode;
  double? price;
  int? stock;
  int? lowStock;
  String? spData;
  String? pic;
  int? sale;
  int? promotionPrice;
  int? lockStock;

  SkuStock(
      {this.id,
      this.productId,
      this.skuCode,
      this.price,
      this.stock,
      this.lowStock,
      this.spData,
      this.pic,
      this.sale,
      this.promotionPrice,
      this.lockStock});

  SkuStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    skuCode = json['sku_code'];
    price = json['price'] + 0.00;
    stock = json['stock'];
    lowStock = json['low_stock'];
    spData = json['sp_data'];
    pic = json['pic'];
    sale = json['sale'];
    promotionPrice = json['promotion_price'];
    lockStock = json['lock_stock'];
  }
}

class ProductLadder {
  int? id;
  int? productId;
  int? count;
  int? discount;
  int? price;

  ProductLadder(
      {this.id, this.productId, this.count, this.discount, this.price});

  ProductLadder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    count = json['count'];
    discount = json['discount'];
    price = json['price'];
  }
}

class ProductFullReduction {
  int? id;
  int? productId;
  int? fullPrice;
  int? reducePrice;

  ProductFullReduction(
      {this.id, this.productId, this.fullPrice, this.reducePrice});

  ProductFullReduction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    fullPrice = json['full_price'];
    reducePrice = json['reduce_price'];
  }
}

class ProductAttrValue {
  int? id;
  int? productId;
  int? productAttributeId;
  String? value;

  ProductAttrValue(
      {this.id, this.productId, this.productAttributeId, this.value});

  ProductAttrValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productAttributeId = json['product_attribute_id'];
    value = json['value'];
  }
}

class MemberPrice {
  int? id;
  int? productId;
  int? memberLevelId;
  int? memberPrice;
  String? memberLevelName;

  MemberPrice(
      {this.id,
      this.productId,
      this.memberLevelId,
      this.memberPrice,
      this.memberLevelName});

  MemberPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    memberLevelId = json['member_level_id'];
    memberPrice = json['member_price'];
    memberLevelName = json['member_level_name'];
  }
}

class ProductAttribute {
  int? id;
  int? categoryAttributeId;
  int? selectType;
  int? inputType;
  int? sort;
  int? filterType;
  int? searchType;
  int? relatedStatus;
  int? handAddStatus;
  int? type;
  String? name;
  String? inputList;

  ProductAttribute(
      {this.id,
      this.categoryAttributeId,
      this.selectType,
      this.inputType,
      this.sort,
      this.filterType,
      this.searchType,
      this.relatedStatus,
      this.handAddStatus,
      this.type,
      this.name,
      this.inputList});

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryAttributeId = json['category_attribute_id'];
    selectType = json['select_type'];
    inputType = json['input_type'];
    sort = json['sort'];
    filterType = json['filter_type'];
    searchType = json['search_type'];
    relatedStatus = json['related_status'];
    handAddStatus = json['hand_add_status'];
    type = json['type'];
    name = json['name'];
    inputList = json['input_list'];
  }
}

class Parameters {
  String? key;
  String? value;
  Parameters({this.key, this.value});
  Parameters.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    value = json["value"];
  }
}
