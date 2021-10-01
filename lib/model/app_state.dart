import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/model/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final List<Category> category;
  final List<Product> product;
  final List<Product> cartProducts;
  

  AppState({@required this.user,@required this.category,@required this.product,@required this.cartProducts});

  factory AppState.initial() {
    return AppState(user: null, category:[],product:[],cartProducts:[]);
  }
}