import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/user.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    category: categoryReducer(state.category, action)
  );
}

User userReducer(User user, dynamic action) {
  if(action is GetUserAction){
    //return user from action
    return action.user;
  }
  return user;
}

categoryReducer( category, dynamic action) {
   if(action is GetCategoryAction){
    //return user from action
    return action.category;
   }
  return category;
}