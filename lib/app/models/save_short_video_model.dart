import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class SaveShortVideoRootModel {
  SaveShortVideoRootModel({
    required this.id,
    required this.articleId,
    required this.title,
    required this.videoImage,
    required this.videoFile,
    required this.vlabelIds,
    required this.weigh,
    required this.ifPrivate,
  });

  factory SaveShortVideoRootModel.fromJson(Map<String, dynamic> json) =>
      SaveShortVideoRootModel(
        id: asT<int>(json['id'])!,
        articleId: asT<int>(json['article_id'])!,
        title: asT<String>(json['title'])!,
        videoImage: asT<String>(json['video_image'])!,
        videoFile: asT<String>(json['video_file'])!,
        vlabelIds: asT<String>(json['vlabel_ids'])!,
        weigh: asT<String>(json['weigh'])!,
        ifPrivate: asT<int>(json['if_private'])!,
      );

  int id;
  int articleId;
  String title;
  String videoImage;
  String videoFile;
  String vlabelIds;
  String weigh;
  int ifPrivate;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'article_id': articleId,
        'title': title,
        'video_image': videoImage,
        'video_file': videoFile,
        'vlabel_ids': vlabelIds,
        'weigh': weigh,
        'if_private': ifPrivate,
      };
}
