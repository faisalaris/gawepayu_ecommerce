import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/pages/products_detail_page.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';


class ProductItem extends StatefulWidget {
final Product itemPro;
  ProductItem({this.itemPro});

  @override
  ProductItemState createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
   bool _isInCart(AppState state, dynamic id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }
  @override
  Widget build(BuildContext context) {
    //final String pictureUrl = 'https://'+AppLink.link3+'${widget.itemPro.image[0].url}';
    return InkWell(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ProductsDetailPage(itemPro: widget.itemPro))),
    child:GridTile(
        footer: GridTileBar(
            title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(widget.itemPro.name, style: TextStyle(fontSize: 20.0))),
                subtitle: Text("\Rp. ${widget.itemPro.harga}", style: TextStyle(fontSize: 20.0)),
            backgroundColor: Colors.red[700],
            trailing: StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (_, state) {
                      return state.user != null
                       ? IconButton(
                              icon: Icon(Icons.shopping_cart),
                              color: _isInCart(state, widget.itemPro.id)
                                  ? Colors.black
                                  : Colors.white,
                              onPressed: () {
                                StoreProvider.of<AppState>(context)
                                    .dispatch(toggleCartProductAction(widget.itemPro));
                              })
                          : Text('');
                    })
          ),
          child: Hero(
                tag: widget.itemPro,
        child: Image.asset('Logo.png', fit: BoxFit.cover))));
  }
}