import 'dart:convert';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/model/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// User Actions
ThunkAction<AppState> getUserAction = (Store<AppState> store) async{

final prefs = await SharedPreferences.getInstance();
final String storedUser = prefs.
getString('user'); 
final user = storedUser != null ? User.fromJson(json.decode(storedUser)) : null ;

store.dispatch(GetUserAction(user));

};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class LogoutUserAction {
  final User _user;

  User get user => this._user;

  LogoutUserAction(this._user);
}


class GetUserAction{
final User _user;

User get user => this._user;
GetUserAction(this._user);
}

// Category Action

ThunkAction<AppState> getCategoryAction = (Store<AppState> store) async{
Uri url = new Uri.https(AppLink.link3,'/categories');
http.Response response = await http.get(url);
final List<dynamic> responseData = json.decode(response.body);
List<Category>categorys = [];
responseData.forEach((categoryData){
 final Category category =Category.fromJson(categoryData);
 categorys.add(category);
}
);
store.dispatch(GetCategoryAction(categorys));
}; 

class GetCategoryAction{
  final List<Category> _category ;

  List<Category> get category => this._category;
  GetCategoryAction(this._category);
}

// Product Action
ThunkAction<AppState> getProductAction = (Store<AppState> store) async{
       Map<String, String> qParams = {
      '_limit' : '-1'
    };  
Uri url = new Uri.https(AppLink.link3,'/products',qParams);
http.Response response = await http.get(url);
final List<dynamic> responseData = json.decode(response.body);
List<Product> products = [];
responseData.forEach((productData){
 final Product product =Product.fromJson(productData);
 products.add(product);
}
);
store.dispatch(GetProductAction(products));
}; 

class GetProductAction{
  final List<Product> _product ;

  List<Product> get product => this._product;
  GetProductAction(this._product);
}

/* Cart Products Actions */
ThunkAction<AppState> toggleCartProductAction(Product cartProduct) {
  return (Store<AppState> store) async {
    final List<Product> cartProducts = store.state.cartProducts;
    final User user = store.state.user;
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    bool isInCart = index > -1 == true;
    List<Product> updatedCartProducts = List.from(cartProducts);
    if (isInCart) {
      updatedCartProducts.removeAt(index);
    } else {
      updatedCartProducts.add(cartProduct);
    }
      final List<dynamic> cartProductsIds =
        updatedCartProducts.map((product) => product.id).toList();
        Uri url = new Uri.https(AppLink.link3,'/carts/${user.cartId}');
        Map<String, dynamic> jsoncek = {"products": "1"};
        dynamic jsonbody = jsonEncode(jsoncek);
        print(jsonbody);
        final response = await http.put(url,
        // headers: <String, String> {
        //   "Authorization": "Bearer ${user.jwt}",
        //   'Content-Type': 'application/json; charset=utf-8'
        //   },
        body: {"products": json.encode(cartProductsIds)},
        headers: {"Authorization": "Bearer ${user.jwt}"});
    
    store.dispatch(ToggleCartProductAction(updatedCartProducts));
  };
}

ThunkAction<AppState> addRemoveCountCartProductAction(Product cartProduct,dynamic count) {
  return (Store<AppState> store) {
    final List<Product> cartProducts = store.state.cartProducts;
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    bool isInCart = index > -1 == true;
    List<Product> updatedCartProducts = List.from(cartProducts);
    if (isInCart) {
      updatedCartProducts[index].jumlah = count ;
    } 
    store.dispatch(AddRemoveCountCartProductAction(updatedCartProducts));
  };
}

ThunkAction<AppState> removeCartProductAction(Product cartProduct) {
  return (Store<AppState> store) {
    final List<Product> cartProducts = store.state.cartProducts;
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    List<Product> updatedCartProducts = List.from(cartProducts);
      updatedCartProducts.removeAt(index);
    store.dispatch(RemoveCartProductAction(updatedCartProducts));
  };
}

ThunkAction<AppState> getCartProductsAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  if (storedUser == null) {
    return;
  }
  final User user = User.fromJson(json.decode(storedUser));
  Uri url = new Uri.https(AppLink.link3,'/carts/${user.cartId}');
  http.Response response = await http.get(url,
      headers: {'Authorization': 'Bearer ${user.jwt}'});
  final responseData = json.decode(response.body)['products'];
  List<Product> cartProducts = [];
  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    cartProducts.add(product);
  });
  store.dispatch(GetCartProductsAction(cartProducts));
};

class ToggleCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ToggleCartProductAction(this._cartProducts);
}

class AddRemoveCountCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  AddRemoveCountCartProductAction(this._cartProducts);
}

class RemoveCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  RemoveCartProductAction(this._cartProducts);
}

class GetCartProductsAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  GetCartProductsAction(this._cartProducts);
}


/* Checkout Products Actions */

ThunkAction<AppState> getCheckoutCartProductAction(List<Product> cartProduct) {
  return (Store<AppState> store) {
    final List<Product> cartProducts = cartProduct;
     List<Product> checkoutcartProducts = [];
    checkoutcartProducts = List.from(cartProducts);
    store.dispatch(CheckoutCartProductAction(checkoutcartProducts));
  };
}

ThunkAction<AppState> addRemoveCheckoutCountCartProductAction(Product chekoutcartProduct,dynamic count) {
  return (Store<AppState> store) {
    final List<Product> checkoutcartProducts = store.state.checkoutProducts;
    final int index =
        checkoutcartProducts.indexWhere((product) => product.id == chekoutcartProduct.id);
    bool isInCart = index > -1 == true;
    List<Product> updatedCheckoutCartProducts = List.from(checkoutcartProducts);
    if (isInCart) {
      updatedCheckoutCartProducts[index].jumlah = count ;
    } 
    store.dispatch(AddRemoveCountCheckoutCartProductAction(updatedCheckoutCartProducts));
  };
}

ThunkAction<AppState> removeCheckoutCartProductAction(Product chekoutcartProduct) {
  return (Store<AppState> store) {
    final List<Product> checkoutcartProducts = store.state.checkoutProducts;
    final int index =
        checkoutcartProducts.indexWhere((product) => product.id == chekoutcartProduct.id);
    List<Product> updatedCheckoutCartProducts = List.from(checkoutcartProducts);
      updatedCheckoutCartProducts.removeAt(index);
    store.dispatch(RemoveChekoutCartProductAction(updatedCheckoutCartProducts));
  };
}

class CheckoutCartProductAction {
  final List<Product> _checkoutcartProducts;

  List<Product> get checkoutProducts => this._checkoutcartProducts;

  CheckoutCartProductAction(this._checkoutcartProducts);
}

class AddRemoveCountCheckoutCartProductAction {
  final List<Product> _checkoutcartProducts;

  List<Product> get checkoutProducts => this._checkoutcartProducts;

  AddRemoveCountCheckoutCartProductAction(this._checkoutcartProducts);
}

class RemoveChekoutCartProductAction {
  final List<Product> _checkoutcartProducts;

  List<Product> get checkoutProducts => this._checkoutcartProducts;

  RemoveChekoutCartProductAction(this._checkoutcartProducts);
}
