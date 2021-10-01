import 'package:flutter/material.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/pages/products_page.dart';

class CategoryItem extends StatefulWidget {
  final Category itemCat;
  final List<Product> itemPro;
  CategoryItem({this.itemCat,this.itemPro});

  @override
  CategoryItemState createState() => CategoryItemState();

}

class CategoryItemState extends State<CategoryItem> {
  List<Product> tempList2 = [];


  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'https://'+AppLink.link3+'${widget.itemCat.image[0].url}';
    return InkWell(
              onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductsPage (itemPro: widget.itemPro,itemCat: widget.itemCat);
            }));},
    child: 
    GridTile(
        footer: GridTileBar(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(widget.itemCat.description, style: TextStyle(fontSize: 20.0))),
            backgroundColor: Color(0xBB000000),
          ),
        child: Image.network(pictureUrl, fit: BoxFit.cover)));
  }
}

