import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;
  HomePage({this.onInit});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
    Icon _searchIcon = new Icon(Icons.search);
    String _searchText = '';
    final TextEditingController _filter = new TextEditingController();
    Widget _appBarTitle = new Text( 'Search Product (deskripsi)' ,style: TextStyle(color: Colors.white) ,);
    int _currentIndex = 0;

  HomePageState(){
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
      widget.onInit();
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
          hintText: 'Cari...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('Search Product (deskripsi)',style: TextStyle(color: Colors.white));
      _filter.clear();
    }
  });
}

//# Region Appbar
   Widget _appBar() { 
     return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
                centerTitle: true,
                title:_appBarTitle ,
                actions: [
                 new IconButton
                (icon: _searchIcon, 
                onPressed: _searchPressed,
                   ),
                     new IconButton
                (icon: Icon(Icons.shopping_cart), 
                onPressed: (){}
                ),
                ]
                );
          }));
   }

  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label:"Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_support),
          label:"Hubungi kami",
        )
      ],
      onTap: (index){
        setState(() {
                  _currentIndex = index;
                });
      },
    );

  }
//# End Region Appbar

//# Region Drawer
  Widget _drawerBuilder(){
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
          builder: (context, state) {
            return SizedBox(
  width: MediaQuery.of(context).size.width * 0.5,
   child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(state),
          _createDrawerItem(icon: Icons.account_circle, text: "Akun Saya"),
          _createDrawerItem(icon: Icons.bookmark, text: "Syarat dan \nketentuan"),
           _createDrawerItem(icon: Icons.exit_to_app, text: "Logout"),
        ],
      ),
    ));});
  }

  Widget _createHeader(state) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:  AssetImage('assets/halaman web payu Home.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(state.user.username,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}
  Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, color:Theme.of(context).primaryColor),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text, style: TextStyle(color: Theme.of(context).primaryColor)),
        )
      ],
    ),
    onTap: onTap,
  );
}
//# End Region Drawer

//# Region Carousel image
    Widget _carouselItem({String image}){
      return Container(
         margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
      );
    }

    Widget _carouselImage(){
      return CarouselSlider(
        items: [
          _carouselItem(image :"assets/promo1.jpeg"),
          _carouselItem(image :"assets/promo2.png"),
          _carouselItem(image :"assets/promo3.png"),
          _carouselItem(image :"assets/promo4.jpeg"),
        ],
        options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
      );
    }

//$ End Regiom Carousel image 

// Region Category
Widget _gridview(){
  return StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
           return Flexible(
              child:GridView.builder(
                itemCount: state.category.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemBuilder: (context,i) => Text(state.category[i]),
              )
             
           );  
          }
          );
} 


// End Region Category
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        drawer: _drawerBuilder(), 
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                      child: Column(children: [
                      _gridview()
            ]))))),
        bottomNavigationBar: _bottomBar(),
        );
  }
}

