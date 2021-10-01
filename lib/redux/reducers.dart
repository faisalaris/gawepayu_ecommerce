import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/category.dart';
import 'package:gawepayu_ecommerce/model/Product.dart';
import 'package:gawepayu_ecommerce/model/user.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    category: categoryReducer(state.category, action),
    product: productReducer(state.product, action),
    cartProducts: cartProducts(state.cartProducts, action)
  );
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Category> categoryReducer(List<Category> category, dynamic action) {
   if(action is GetCategoryAction){
    //return user from action
    return action.category;
   }
  return category;
}

List<Product> productReducer(List<Product> product, dynamic action) {
   if(action is GetProductAction){
    //return user from action
    return action.product;
   }
  return product;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
   if (action is GetCartProductsAction) {
    return action.cartProducts;
  }
  else if (action is ToggleCartProductAction) {
    return action.cartProducts;
  }
  else if (action is AddRemoveCountCartProductAction){
    return action.cartProducts;
  }
   else if (action is RemoveCartProductAction){
    return action.cartProducts;
  }
  return cartProducts;
}