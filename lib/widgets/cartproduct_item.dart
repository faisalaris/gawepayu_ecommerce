import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';

class CartProductItem extends StatefulWidget {
final Product itemcart;

 CartProductItem({this.itemcart});

  @override
  CartProductItemState createState() => CartProductItemState();

}
 
 class CartProductItemState extends State<CartProductItem> {
  dynamic _count = 0;

 void _increament(){
   setState((){ 
     _count ++;
   });
 } 

 void _decreament(){
   setState((){ 
     _count --;
   });
 } 
@override
  Widget build(BuildContext context) {
    //final String pictureUrl = 'https://'+AppLink.link3+'${widget.itemcart.image[0].url}';
             return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Card(
                elevation: 4.0,
                child: Column(
                 children: <Widget>[ 
                  ListTile(
                  leading: Image.asset('Logo.png', fit: BoxFit.cover),
                  title:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(child: Text(widget.itemcart.name),)
                        ]
                      ),
                      SizedBox(height: 10),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Text("\Rp. ${widget.itemcart.harga}", style: TextStyle(fontSize: 15.0,color:Colors.yellow[700])),
                        ]
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                         GestureDetector(
                           onTap: () {
                                    StoreProvider.of<AppState>(context)
                                    .dispatch(removeCartProductAction(widget.itemcart));
                           }, // handle your image tap here
                           child: Icon(Icons.delete, color: Theme.of(context).primaryColor),
                         ),
                         SizedBox(width: 100), 
                        GestureDetector(
                                onTap: () {
                                    _increament();
                                    StoreProvider.of<AppState>(context)
                                    .dispatch(addRemoveCountCartProductAction(widget.itemcart,_count));
                                }, // handle your image tap here
                                child: Icon(Icons.add_circle, color: Theme.of(context).primaryColor),
                         ),
                         SizedBox(width: 10),
                         GestureDetector(
                                onTap: () {
                                    _decreament();
                                    StoreProvider.of<AppState>(context)
                                    .dispatch(addRemoveCountCartProductAction(widget.itemcart,_count));
                                }, // handle your image tap here
                                child: Icon(Icons.remove_circle, color: Theme.of(context).primaryColor),
                         ),
                          SizedBox(width: 15),
                          Text(_count.toString())  
                           
                             
                           ]
                         )
                        ]
                      )
                    
                  ) 
                ,]
              ),
            ));
  }
}

