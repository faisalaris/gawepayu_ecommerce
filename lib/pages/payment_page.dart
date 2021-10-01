import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/widgets/cartproduct_item.dart';
import 'package:gawepayu_ecommerce/widgets/checkoutproduct_item.dart';

class PaymentPage extends StatefulWidget {
  final String sum ;
  PaymentPage({this.sum});

  @override
  PaymentStatePage createState() => PaymentStatePage();
}

class PaymentStatePage extends State<PaymentPage> {

 bool _pay1 = false;
 bool _pay2 = false;
 bool _pay3 = false;
 bool _pay4 = false;

  bool _bank1 = false;   bool _bank2 = false;   bool _bank3 = false;   bool _bank4 = false;   bool _bank5 = false;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metode Pembayaran'),
      ),
      body: SingleChildScrollView(
      child :Column(
        children: <Widget>[
          
           Padding(padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.all(16.0),
                        child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget> [
                          Text("Pilih Metode Pembayaran",style : TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight:FontWeight.bold))
                          ]
                        )
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          Checkbox(
                           value: _pay1,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: (bool value){
                              setState(() {
                                _pay1 = value;
                                _pay2 =false; _pay3 =false; _pay4 =false; 
                              });
                           },
                          ),
                          SizedBox(width: 20,),
                          Text("Bayar di tempat")
                          ]
                        ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          Checkbox(
                           value: _pay2,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: (bool value){
                              setState(() {
                                _pay2 = value;
                                _pay1 =false; _pay3 =false; _pay4 =false; 
                              });
                           },
                          ),
                          SizedBox(width: 20,),
                          Text("Internet Banking")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          Checkbox(
                           value: _pay3,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: (bool value){
                             setState(() {
                                _pay3 = value;
                                _pay1 =false; _pay2 =false; _pay4 =false; 
                              });
                           },
                          ),
                          SizedBox(width: 20,),
                          Text("Transfer ATM")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          Checkbox(
                           value: _pay4,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: (bool value){
                             setState(() {
                                _pay4 = value;
                                _pay1 =false; _pay3 =false; _pay2 =false; 
                              });
                           },
                          ),
                          SizedBox(width: 20,),
                          Text("Transfer Manual")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          SizedBox(width: 20,),   
                          Checkbox(
                           value: _pay4 != true ? false :_bank1,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: _pay4 != true ? null :
                            (bool value){
                             setState(() {
                                _bank1 = value;
                                _bank2 =false; _bank3 =false; _bank4 =false; _bank5 =false;
                              });
                           },
                          ),  
                          SizedBox(width: 20,),
                          SizedBox(width: 100,height: 100,
                          child: Image.asset('BCA.png', fit: BoxFit.fill),
                          ),
                          SizedBox(width: 20,),
                          Text("Bank BCA")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          SizedBox(width: 20,),   
                          Checkbox(
                           value: _pay4 != true ? false :_bank2,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: _pay4 != true ? null :
                            (bool value){
                             setState(() {
                                _bank2 = value;
                                _bank1 =false; _bank3 =false; _bank4 =false; _bank5 =false; 
                              });
                           },
                          ),  
                          SizedBox(width: 20,),
                          SizedBox(width: 100,height: 100,
                          child: Image.asset('BNI.png', fit: BoxFit.fill),
                          ),
                          SizedBox(width: 20,),
                          Text("Bank BNI")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          SizedBox(width: 20,),   
                          Checkbox(
                           value: _pay4 != true ? false :_bank3,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: _pay4 != true ? null :
                            (bool value){
                             setState(() {
                                _bank3 = value;
                                _bank1 =false; _bank2 =false; _bank4 =false; _bank5 =false; 
                              });
                           },
                          ),  
                          SizedBox(width: 20,),
                          SizedBox(width: 100,height: 100,
                          child: Image.asset('Mandiri.png', fit: BoxFit.fill),
                          ),
                          SizedBox(width: 20,),
                          Text("Bank Mandiri")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          SizedBox(width: 20,),   
                          Checkbox(
                           value: _pay4 != true ? false :_bank4,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: _pay4 != true ? null :
                            (bool value){
                             setState(() {
                                _bank4 = value;
                                _bank1 =false; _bank2 =false; _bank3 =false; _bank5 =false; 
                              });
                           },
                          ),  
                          SizedBox(width: 20,),
                          SizedBox(width: 100,height: 100,
                          child: Image.asset('BRI.png', fit: BoxFit.fill),
                          ),
                          SizedBox(width: 20,),
                          Text("Bank BRI")
                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                          SizedBox(width: 20,),   
                          Checkbox(
                           value: _pay4 != true ? false :_bank5,
                           activeColor:Theme.of(context).primaryColor ,
                           onChanged: _pay4 != true ? null :
                            (bool value){
                             setState(() {
                                _bank5 = value;
                                _bank1 =false; _bank2 =false; _bank4 =false; _bank3 =false; 
                              });
                           },
                          ),  
                          SizedBox(width: 20,),
                          SizedBox(width: 50,height: 50,
                          child: Image.asset('CIMB.png', fit: BoxFit.fill),
                          ),
                          SizedBox(width: 20,),
                          Text("Bank CIMB")
                          ]
                        ),
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
                        Text('Rp. ${widget.sum}',style: TextStyle(color :Colors.yellow[700]))])      
                  ],
                )
                        ,
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                          ElevatedButton(
                       onPressed: (){  
                     },
                     child: Text("Lanjut"),
                     style: ElevatedButton.styleFrom(
                      fixedSize: Size(150, 40),   
                    shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(50)))
                     , 
                    //  child: Text('Beli ( ${calculateTotalItem(state.cartProducts)} )'))
                     )    
                          ]
                          ),
                        ]
                    ),
                    )
          
        
        ])

    ));}

}