import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/widgets/product_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';


class ProductsPage extends StatefulWidget {
final List<Product> itemPro;
final Category itemCat;
  ProductsPage({this.itemPro,this.itemCat});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = '';
  final TextEditingController _filter = new TextEditingController();
  List<Product> tempList2 = [];
  Widget _appBarTitle = new Text(
    'Search Product (deskripsi)',
    style: TextStyle(color: Colors.white),
  );

  ProductsPageState() {
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

  void initState() {
    super.initState();
      List<Product> tempList = [];
      for (int i = 0; i < widget.itemPro.length; i++) {
       if (widget.itemPro[i].category.id == widget.itemCat.id) {
          tempList.add(widget.itemPro[i]);
          }
       }
       tempList2 =  tempList ;
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
                new Badge(
                      badgeContent: Text(state.cartProducts.length.toString()),
                      badgeColor: Colors.white,
                      child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'))) : 
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

    Widget _gridview(state) {
    return Expanded(
        child: SafeArea(
            top: false,
            bottom: false,
            child: GridView.builder(
                itemCount: tempList2.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    ),
                    
                itemBuilder: (context, i) =>
                   ProductItem(itemPro: tempList2[i]))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawerBuilder(),
      body:Column(children:<Widget> [
      Expanded(child :
      Container(
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                return Column(children: [
                  Text("Produk"),
                  SizedBox(height: 20),
                  _gridview(state),
                ]);
              })
              ),
      
      )]),
      );
  }

}
