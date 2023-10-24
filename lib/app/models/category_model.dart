class Category {
  int? id;
  int? parentId;
  String? icon;
  String? name;
  List<Category>? children;
  bool select = false;
  Category({this.id, this.parentId, this.icon, this.name, this.children});

  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    parentId = json["parentId"];
    icon = json["icon"];
    name = json["name"];
    List<Category> children = [];
    if (json["children"] != null) {
      for (var item in json["children"]) {
        children.add(Category.fromJson(item));
      }
      this.children = children;
    }
  }
}

class CategoryResponse {
  int? code;
  String? detail;
  List<Category>? data;
  CategoryResponse({this.code, this.detail, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    this.code = json["code"];
    this.detail = json["detail"];
    List<Category> category = [];
    if (json["data"] != null) {
      List data = json["data"];
      for (int i = 0; i < data.length; i++) {
        List<Category> children = [];
        for (int j = 0; j < data.length; j++) {
          if (data[j]["parent_id"] != 0 &&
              data[i]["id"] == data[j]["parent_id"]) {
            children.add(Category(
                id: data[j]["id"],
                parentId: data[j]["parent_id"],
                icon: data[j]["icon"],
                name: data[j]["name"],
                children: null));
          }
        }
        if (data[i]["parent_id"] == 0) {
          category.add(Category(
              id: data[i]["id"],
              parentId: data[i]["parent_id"],
              icon: data[i]["icon"],
              name: data[i]["name"],
              children: children));
        }
      }
      this.data = category;
    }
  }
}

class CategoryFilter {
  String name;
  List<CategoryFilterItem>? items;
  CategoryFilter({required this.name, this.items});
  factory CategoryFilter.formJson(Map<String, dynamic> json) {
    String name = json["name"];
    List<CategoryFilterItem>? items = [];

    for (var val in json["items"]) {
      CategoryFilterItem item = CategoryFilterItem.fromJson(json["items"]);
      items.add(item);
    }

    return CategoryFilter(name: name, items: items);
  }
}

class CategoryFilterItem {
  String name;
  int id;
  int sort;
  String fileds;
  bool seletecd;
  CategoryFilterItem(
      {required this.name,
      required this.id,
      required this.sort,
      required this.fileds,
      required this.seletecd});
  factory CategoryFilterItem.fromJson(Map<String, dynamic> json) {
    return CategoryFilterItem(
        name: json["name"],
        id: json["id"],
        sort: json["sort"],
        fileds: "",
        seletecd: false);
  }
}
