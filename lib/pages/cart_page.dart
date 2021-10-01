import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/widgets/cartproduct_item.dart';
import 'package:gawepayu_ecommerce/pages/checkout_page.dart';

class CartPage extends StatefulWidget {
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {

  String calculateTotalPrice(cartProducts) {
    double totalPrice = 0.0;
    cartProducts.forEach((cartProduct) {
      totalPrice += double.parse(cartProduct.harga) *cartProduct.jumlah;
    });
    return totalPrice.toStringAsFixed(2);
  }

  String calculateTotalItem(cartProducts) {
    int totalItem = 0;
    cartProducts.forEach((cartProduct) {
      totalItem += cartProduct.jumlah;
    });
    return totalItem.toString();
  }

  Widget _listview(state)
  {
    return 
    Expanded(
        child: SafeArea(
            top: false,
            bottom: false,
            right: false,
            child:
    ListView.builder(
       scrollDirection: Axis.vertical,
        shrinkWrap: true,
          itemCount: state.cartProducts.length,
          itemBuilder: (context, index) =>
            CartProductItem(itemcart:state.cartProducts[index]))));}
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Column(children:<Widget> [
      Expanded(child :
      Container(
        child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                
              return 
               state.cartProducts.length > 0 ?  
              Column(children: [
                _listview(state) ,
              Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                     Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                     Text('Total Harga : Rp. ${calculateTotalPrice(state.cartProducts)}')
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                     ElevatedButton(onPressed: (){
                    StoreProvider.of<AppState>(context)
                                    .dispatch(getCheckoutCartProductAction(state.cartProducts));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return CheckOutPage (itemCart: state.cartProducts);
            }));}, 
                     child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                  ],
                ),
                  ]
                ),
                )
      ]
      ) : 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text('Tidak ada data keranjang')
          ]
        ),
      );} 
      )
      ),
      )]
      ));
  }
}



// return Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//               child: Card(
//                 elevation: 4.0,
//                 child: ListTile(
//                   leading: Icon(
//                     item.icon,
//                     color: item.color,
//                   ),
//                   title: Text(item.name),
//                   trailing: GestureDetector(
//                       child: Icon(
//                         Icons.remove_circle,
//                         color: Colors.red,
//                       ),
//                       onTap: () {
//                         setState(() {
//                           state.cartProducts.remove(item);
//                         });
//                       }),
//                 ),
//               ),
//             )