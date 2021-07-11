import 'package:flutter/material.dart';
import 'package:gawepayu_ecommerce/pages/home_page.dart';
import 'package:gawepayu_ecommerce/pages/login_page.dart';
import 'package:gawepayu_ecommerce/pages/register_page.dart';
import 'package:gawepayu_ecommerce/redux/actions.dart';
import 'package:gawepayu_ecommerce/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:gawepayu_ecommerce/model/app_state.dart';


void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return StoreProvider(
      store: store,
      child :MaterialApp(
      title: 'Flutter Demo',
          routes: {
          '/login': (BuildContext context) => LoginPage(),
          '/register': (BuildContext context) => RegisterPage(),
          '/home': (BuildContext context) => HomePage(
            onInit :(){
              StoreProvider.of<AppState>(context).dispatch(getUserAction);
              StoreProvider.of<AppState>(context).dispatch(getCategoryAction);
            }

          )
        },
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red[700],
          accentColor: Colors.white,
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.red[700]),
              headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 18.0, color: Colors.red[700]))),
      home: RegisterPage(),
    ));
  }
}

