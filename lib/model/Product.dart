import 'dart:convert';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:meta/meta.dart';

class Product {
  dynamic id;
  String name;
  String kondisi;
  String berat;
  String deskripsi;
  dynamic harga;
  dynamic jumlah = 0;
  List<ProdImage> image;
  Category category;

  Product(
    {@required this.id,@required this.name,@required this.kondisi,
    @required this.berat,@required this.deskripsi,@required this.harga,@required this.image,@required this.category
    } );

    factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['Name'],
        kondisi: json['kondisi'],
        berat: json['Berat'],
        deskripsi: json['Deskripsi'],
        harga: json['harga'],
        image: json['image']== null ? null: List<ProdImage>.from(json["image"].map((x) => ProdImage.fromJson(x))),
        category:  Category.fromJson(json['category'])
        );
  }

}

List<Product> getProductFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class ProdImage {
  dynamic id;
  String name;
  String url;

ProdImage(
      {this.id,
      this.name,
      this.url,
});
  factory ProdImage.fromJson(Map<String, dynamic> json) {
    return ProdImage(
      id : json['id'],
      name : json['name'],
      url : json['url']
    );
  }
}