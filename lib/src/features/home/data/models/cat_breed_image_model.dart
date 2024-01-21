import '../../domain/entities/cat_breed_image_entity.dart';

class CatImageModel extends CatImageEntity {
  CatImageModel({
    required super.id,
    required super.url,
    required super.width,
    required super.height,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) => CatImageModel(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
