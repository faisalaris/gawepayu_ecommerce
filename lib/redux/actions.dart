import 'dart:convert';
import 'package:gawepayu_ecommerce/model/app_state.dart';
import 'package:gawepayu_ecommerce/model/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const link = '192.168.100.25:1337';
// User Actions
ThunkAction<AppState> getUserAction = (Store<AppState> store) async{

final prefs = await SharedPreferences.getInstance();
final String storedUser = prefs.getString('user');
final user = storedUser!= null ? User.fromJson(json.decode(storedUser)) : null ;

store.dispatch(GetUserAction(user));

};

class GetUserAction{
final User _user;

User get user => this._user;
GetUserAction(this._user);
}

// Category Action

ThunkAction<AppState> getCategoryAction = (Store<AppState> store) async{
Uri url = new Uri.http(link,'/categories');
http.Response response = await http.get(url);
final List<dynamic> responseData = json.decode(response.body);
store.dispatch(GetCategoryAction(responseData));
}; 

class GetCategoryAction{
  final List<dynamic> _category ;

  List<dynamic> get category => this._category;
  GetCategoryAction(this._category);
}