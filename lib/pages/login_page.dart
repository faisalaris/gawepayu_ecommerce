import 'package:flutter/material.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';
import 'package:gawepayu_ecommerce/model/errorMsge.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSubmitting,_obsecureText = true;
  bool _rememberMe = false ;
  String _userName,_password;

  Widget _showTitle() {
    return Text('Masuk',
        style: Theme.of(context).textTheme.headline1);
  }

    Widget _showText() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child : Center(
          child : Column(
            children: <Widget>[
              Text('Atau Masuk Dengan',
                style: TextStyle(color: Theme.of(context).primaryColor))
            ],
          )
        )) ;
    }

    Widget _showGoogleLogin() {
    return Center(child: 
    Padding(
        padding: EdgeInsets.only(top: 20.0),
          child : Column(
            children: <Widget>[
           GestureDetector(
           onTap: () {}, // handle your image tap here
          child: Image.asset(
            'google.png',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),),
          SizedBox(height: 20,),
          GestureDetector(
          onTap: () {}, // handle your image tap here
          child: Image.asset(
            'facebook.png',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),),
            ],
          )
        )) ;
    }


  Widget _showUsernameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
              validator: (val) {
              if(val.isEmpty){
                return "Username wajib di isi" ;
              }
              else if (val.length < 6){
                return "Username minimal 6 karakter" ;
              }
              else
              return null;
            },
            onSaved: (val)=> _userName =val,         
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'isi username, min 6 karakter',
                icon:
                    Icon(Icons.account_circle, color: Theme.of(context).primaryColor))));
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
            obscureText: _obsecureText,
            validator: (val) {
              if(val.isEmpty){
                return "password wajib di isi" ;
              }
              else if (val.length < 6){
                return "password minimal 6 karakter" ;
              }
              else
              return null;
            },
            onSaved: (val)=> _password =val,     
            decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() => _obsecureText = !_obsecureText);
                  },
                  child: Icon(
                    _obsecureText ? Icons.visibility : Icons.visibility_off
                    ),
                ),
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'isikan password, min 6 karakter',
                icon:
                    Icon(Icons.lock, color: Theme.of(context).primaryColor))));
  }

 Widget _showForgetPassword() {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                width: 30,),
                  Checkbox(
                    value: _rememberMe,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                  ),
                  Text("Ingat Saya",
                      style: TextStyle(color: Theme.of(context).primaryColor)),             
                ],
              ),
              SizedBox(
                width: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                 TextButton(
                 child: Text(
                'Lupa kata sandi ?',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => print("lupa"))
                ],
              )
            ]);
  }
    

  Widget _showFormActions() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
           _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor))
              :
          ElevatedButton(
              child: Text('Masuk',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Theme.of(context).colorScheme.secondary)),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  elevation: MaterialStateProperty.all<double>(8.0),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)));
                  })),
              onPressed: _submit) ,
          TextButton(
              child: Text(
                'Belum punya akun payu? Daftar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/register'))
        ]));
  }

void _submit() {
  final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    }
}

 void _registerUser() async {
    setState(() => _isSubmitting = true);
    Uri url = new Uri.https(AppLink.link3,'/auth/local');
    http.Response response = await http.post(url,
        body: {"identifier": _userName, "password": _password, });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200){
        setState(() => _isSubmitting = false);
        _storeUserData(responseData);
        _showSuccessSnack();
        _redirectUser();
        print(responseData);
    }
    else {
      setState(() => _isSubmitting = false) ;
    ErrorMessage errormessage = new ErrorMessage();
    errormessage = ErrorMessage.fromJson(responseData);
      final String errorMsg = errormessage.data[0].messages[0].message;
      _showErrorSnack(errorMsg);
    }
  }
  
  //  void _registerUser() async {
  //   setState(() => _isSubmitting = true);
  //   final _body = {"username": _userName, "password": _password, };
  //   final _body2 = json.encode(_body);
  //   final _header = {"Content-Type": "application/json"};
  //   Uri url = new Uri.http(AppLink.link2,AppLink.path + 'sessions');
  //   http.Response response = await http.post(url,
  //        headers: _header,
  //       body: _body2);
  //   final responseData = json.decode(response.
  //   body);
  //   if (response.statusCode == 201){
  //       setState(() => _isSubmitting = false);
  //       //_storeUserData(responseData);
  //       _showSuccessSnack();
  //       _redirectUser();
  //       print(responseData);
  //   }
  //   else {
  //     setState(() => _isSubmitting = false) ;
  //   ErrorMessage errormessage = new ErrorMessage();
  //   errormessage = ErrorMessage.fromJson(responseData);
  //     final String errorMsg = errormessage.data[0].messages[0].message;
  //     _showErrorSnack(errorMsg);
  //   }
  // }
   void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }
  
   void _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text('User successfully logged in!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formkey.currentState.reset();
  }

     void _showErrorSnack(String errormg) {
    final snackbar = SnackBar(
        content: Text(errormg,
            style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error registering : $errormg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Masuk')),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,  
                      child: Column(children: [
              _showTitle(),
              _showUsernameInput(),
              _showPasswordInput(),
              _showForgetPassword(),
              _showText(),
              _showGoogleLogin(),
              _showFormActions()
            ]))))));
  }
  
  }
