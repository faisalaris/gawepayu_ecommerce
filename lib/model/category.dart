import 'dart:convert';
import 'package:meta/meta.dart';

class Category {
  dynamic id;
  String description;
  List<CatImage> image;

  Category(
      {@required this.id,
      @required this.description,
      @required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        description: json['description'],
        image: json['image']== null ? null: List<CatImage>.from(json["image"].map((x) => CatImage.fromJson(x))));
  }
}

List<Category> getCategoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

class CatImage {
  dynamic id;
  String name;
  String url;

CatImage(
      {this.id,
      this.name,
      this.url,
});
  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(
      id : json['id'],
      name : json['name'],
      url : json['url']
    );
  }
}
