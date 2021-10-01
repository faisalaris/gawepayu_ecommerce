import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/widgets/product_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';


class ProductsDetailPage extends StatefulWidget {
final Product itemPro;
  ProductsDetailPage({this.itemPro});

  @override
  ProductsDetailPageState createState() => ProductsDetailPageState();
}

class ProductsDetailPageState extends State<ProductsDetailPage> {
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = '';
  final TextEditingController _filter = new TextEditingController();
  List<Product> tempList2 = [];
  Widget _appBarTitle = new Text(
    'Search Product (deskripsi)',
    style: TextStyle(color: Colors.white),
  );

  ProductsDetailPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: new Icon(Icons.search),
              hintText: 'Cari...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Product (deskripsi)',
            style: TextStyle(color: Colors.white));
        _filter.clear();
      }
    });
  }

Widget _appBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return AppBar(centerTitle: true, title: _appBarTitle, actions: [
                new IconButton(
                  icon: _searchIcon,
                  onPressed: _searchPressed,
                ),state.user != null ?
                new IconButton(
                    icon: Icon(Icons.shopping_cart), onPressed: () {}) : 
                    TextButton(
                      child: Text('Login'),
                       style: TextButton.styleFrom(primary: Colors.white),
                      onPressed: () =>
                                Navigator.pushNamed(context, '/login')
                    ),
                    state.user != null ?
                    Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage("assets/Logo.png")
                              ),
                              color: Colors.white,
                          ),       
                        ) : Text('')
              ]);
            }));
  }
  
   Widget _drawerBuilder() {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _createDrawerHeader(state),
                    state.user != null ?
                    _createDrawerItem(
                        icon: Icons.account_circle, text: "Akun Saya")
                        : Text(''),
                    _createDrawerItem(
                        icon: Icons.bookmark, text: "Syarat dan \nketentuan"),
                     StoreConnector<AppState, VoidCallback>(
                                                 converter: (store) {
                        return () => store.dispatch(logoutUserAction);
                      }, builder: (_, callback) {
                        return state.user != null
                            ?  _createDrawerItem(icon: Icons.exit_to_app, text: "Logout",onTap: callback)
                            : Text('');
                      }),   
                   
                  ],
                ),
              ));
        });
  }

  Widget _createDrawerHeader(state) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/halaman web payu Home.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: 
              state.user != null ?
              Text(state.user.username,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)) 
                : Text('')),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Theme.of(context).primaryColor),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,
                style: TextStyle(color: Theme.of(context).primaryColor)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final String pictureUrl = 'https://'+AppLink.link3+'${widget.itemPro.image[0].url}';
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawerBuilder(),
      body:Column(children:<Widget> [
      Expanded(child :
      Container(
             child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Hero(
                    tag: widget.itemPro,
                    child: Image.asset('Logo.png',
                        width: orientation == Orientation.portrait ? 600 : 250,
                        height: orientation == Orientation.portrait ? 400 : 200,
                        fit: BoxFit.cover)),
              ),
              Text(widget.itemPro.name, style: Theme.of(context).textTheme.bodyText2),
              Text('Rp. ${widget.itemPro.harga}', style: Theme.of(context).textTheme.bodyText2),
              Flexible(
                  child: SingleChildScrollView(
                      child: Padding(
                          child: Text(widget.itemPro.deskripsi),
                          padding: EdgeInsets.only(
                              left: 32.0, right: 32.0, bottom: 32.0))))
            ])
              ),
      
      )]),
      );
  }

}
