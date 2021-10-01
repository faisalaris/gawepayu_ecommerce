import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/pages/payment_page.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/widgets/cartproduct_item.dart';
import 'package:gawepayu_ecommerce/widgets/checkoutproduct_item.dart';


class CheckOutPage extends StatefulWidget {
  final List<Product> itemCart;
   CheckOutPage({this.itemCart});
   
  @override
  CheckOutStatePage createState() => CheckOutStatePage();
}

class CheckOutStatePage extends State<CheckOutPage> {

  String calculateTotalPrice(cartProducts) {
    double totalPrice = 0.0;
    cartProducts.forEach((cartProduct) {
      totalPrice += double.parse(cartProduct.harga) *cartProduct.jumlah;
    });
    return totalPrice.toStringAsFixed(2);
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
          itemCount: state.checkoutProducts.length,
          itemBuilder: (context, index) =>
            CheckoutCartProductItem(itemcart:state.checkoutProducts[index]))));}


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: 
      Column(children:<Widget> [
      Flexible(child :
      Container(
        child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
              return 
               state.checkoutProducts.length > 0 ?  
              Column(children: [
                Row( 
                mainAxisAlignment: MainAxisAlignment.start,
                children : <Widget> [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Flexible(
                    child:Text("Alamat Pengiriman",style : TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight:FontWeight.bold)),
                  ),
                  )]
                  ),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 16,left: 16),
                  child: Row( 
                mainAxisAlignment: MainAxisAlignment.start,
                children : <Widget> [
                   Flexible(
                    child:Text("Jl. Raya Barat, Pesawahan, Lebaksiu Kidul, Kec. Lebaksiu, Tegal, Jawa Tengah 52461"),
                   )]
                  )
                  ),
                  Padding(
                  padding: const EdgeInsets.only(bottom: 16,right: 16),
                  child: 
                  Row( 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children : <Widget> [
                    ElevatedButton(onPressed: (){  
                     },
                     child: Text("Pilih Alamat Lain"),
                     style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 40),   
                    shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(50)))
                     , 
                    //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                     )
                  ]
                  ))
                  ,
                // SizedBox(
                // height: 40.0,
                // child: TextFormField(
                //  autofocus: false,
                //  initialValue: 'Test Alamat',
                //  style: new TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor),
                //   decoration: InputDecoration(
                //                  hintText: 'Alamat', 
                //                 contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                //                 border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                //                 ) 
                // )),
                _listview(state) ,
              Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                    Padding(padding: const EdgeInsets.all(16.0),
                    child :
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget> [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget> [
                        Text('Total Tagihan',style : TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight:FontWeight.bold)) ]),
                         Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:<Widget> [
                        Text('Rp. ${calculateTotalPrice(state.checkoutProducts)}',style: TextStyle(color :Colors.yellow[700]))])      
                  ],
                )
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                     ElevatedButton(
                       onPressed: (){  
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return PaymentPage (sum:calculateTotalPrice(state.checkoutProducts) ,);
            }));
                     },
                     child: Text("Bayar"),
                     style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 40),   
                    shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(50)))
                     , 
                    //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                     )],
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
            Text('Silakan masukan ke keranjang')
          ]
        ),
      );} 
      )
      ),
      )]
      ));
  }

}