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
      totalPrice += double.parse(cartProduct.harga) * cartProduct.jumlah;
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

    String sumCalculateTotalPrice(cartProducts,ongkos,asuransi,bool asr) {
    double totalPrice = 0.0;
    cartProducts.forEach((cartProduct) {
      totalPrice += double.parse(cartProduct.harga) * cartProduct.jumlah;
    });
    if (asr != true ){
      asuransi = 0 ;
    }
    totalPrice = totalPrice+ongkos+asuransi;
    return totalPrice.toStringAsFixed(2);
  }

  dynamic _ongkos = 18000;
  dynamic _asuransi = 10000;
  bool _asr = false;

  Widget _listview(state) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: state.checkoutProducts.length,
        itemBuilder: (context, index) =>
            CheckoutCartProductItem(itemcart: state.checkoutProducts[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: <Widget>[
              StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (_, state) {
                    return state.checkoutProducts.length > 0
                        ? Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text("Alamat Pengiriman",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ]))
                                ]),
                            Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, left: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(
                                            "Jl. Raya Barat, Pesawahan, Lebaksiu Kidul, Kec. Lebaksiu, Tegal, Jawa Tengah 52461"),
                                      )
                                    ])),
                            Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16, right: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Pilih Alamat Lain"),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(150, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                                      )
                                    ])),
                            SizedBox(
                              height: 250,
                              child: _listview(state),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text("Kurir Pengiriman",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ])),
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Pilih Kurir"),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(150, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                                      ))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Payu Expedition (next day)",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ]))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Rp ${_ongkos.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ]))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Checkbox(
                                                value: _asr,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _asr = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text("Asuransi Pengiriman"),
                                  )]))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text("Ringkasan Belanja",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ]))
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Total Harga Barang ( ${calculateTotalItem(state.checkoutProducts)} Barang )",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ])),
                                    Padding(
                                      padding: const EdgeInsets.only(right :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Rp. ${calculateTotalPrice(state.checkoutProducts)}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ]))      
                                ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Total Ongkos Kirim",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ])),
                                    Padding(
                                      padding: const EdgeInsets.only(right :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                  "Rp. ${_ongkos.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ]))      
                                ]),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: 
                                              _asr != true ? Text("") :
                                              Text(
                                                  "Asuransi",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ])),
                                    Padding(
                                      padding: const EdgeInsets.only(right :16,top : 16),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: 
                                              _asr != true ? Text("") :
                                              Text(
                                                  "Rp. ${_asuransi.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18,
                                                      )),
                                            ),
                                          ]))      
                                ]),  
                            Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Total Tagihan',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                        'Rp. ${sumCalculateTotalPrice(state.checkoutProducts,_ongkos,_asuransi,_asr)}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .yellow[700]))
                                                  ])
                                            ],
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return PaymentPage(
                                                  sum: sumCalculateTotalPrice(state.checkoutProducts,_ongkos,_asuransi,_asr),
                                                );
                                              }));
                                            },
                                            child: Text("Bayar"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size(150, 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50))),
                                            //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                                          )
                                        ],
                                      ),
                                    ]))
                          ])
                        : Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Silakan masukan ke keranjang')
                                ]),
                          );
                  })
            ])));
  }
}
