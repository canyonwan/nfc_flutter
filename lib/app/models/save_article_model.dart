import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class SaveArticleRootModel {
  SaveArticleRootModel({
    required this.id,
    required this.articleId,
    required this.title,
    required this.shareExplain,
    required this.content,
    required this.images,
    required this.vlabelIds,
    required this.ifPrivate,
  });

  factory SaveArticleRootModel.fromJson(Map<String, dynamic> json) =>
      SaveArticleRootModel(
        id: asT<int>(json['id'])!,
        articleId: asT<int>(json['article_id'])!,
        title: asT<String>(json['title'])!,
        shareExplain: asT<String>(json['share_explain'])!,
        content: asT<String>(json['content'])!,
        images: asT<String>(json['images'])!,
        vlabelIds: asT<String>(json['vlabel_ids'])!,
        ifPrivate: asT<int>(json['if_private'])!,
      );

  int id;
  int articleId;
  String title;
  String shareExplain;
  String content;
  String images;
  String vlabelIds;
  int ifPrivate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'article_id': articleId,
        'title': title,
        'share_explain': shareExplain,
        'content': content,
        'images': images,
        'vlabel_ids': vlabelIds,
        'if_private': ifPrivate,
      };
}
