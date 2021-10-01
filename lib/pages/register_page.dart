import 'package:flutter/material.dart';
import 'package:gawepayu_ecommerce/model/errorMsge.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gawepayu_ecommerce/api/api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _nama,_emailHP,_gender,_userName,_password;

  bool _isMale = false;
  bool _isFemale = false;
  bool _isSubmitting,_obsecureText = true;


  Widget _showTitle() {
    return Text('Daftar Akun baru',
        style: Theme.of(context).textTheme.headline1);
  }
   
  Widget _showLogo() { 
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'Logo.png',
            width: 200,
            height: 200,
          ),
        ));
  }

  Widget _showFullnameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
            validator: (val) {
              if(val.isEmpty){
                return "Nama wajib di isi" ;
              }
              else
              return null;
            },
            onSaved: (val)=> _nama =val,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nama Lengkap',
                hintText: 'Nama Lengkap',
                icon:
                    Icon(Icons.face, color: Theme.of(context).primaryColor))));
  }

  Widget _showNoHpEmailInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
            validator: (val) {
              if(val.isEmpty){
                return "email / HP wajib di isi" ;
              }
              else
              return null;
            },
            onSaved: (val)=> _emailHP =val,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email atau Nomor Handphone ',
                hintText: 'isikan Email atau Nomor Handphone',
                icon:
                    Icon(Icons.mail, color: Theme.of(context).primaryColor))));
  }

  Widget _showGendersInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Laki-Laki",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  Checkbox(
                    value: _isMale,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        _isMale = value;
                        _isFemale = false;
                        if(_isMale == true && _isFemale == false){
                         return _gender = 'M' ;
                         }
                        else if (_isFemale == true && _isMale == false){
                        return _gender ='F' ; }
                        else
                        return _gender = 'M';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Perempuan",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  Checkbox(
                    value: _isFemale,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        _isFemale = value;
                        _isMale = false;
                      });
                    },
                  ),
                ],
              )
            ])));
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

  Widget _showTermCondition() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(
            child: 
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Dengan klik daftar, anda telah menyetujui',
                        style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(height:5),
                    Text(
                        'Aturan dan Kebijakan Privasi dari Payu',
                        style: Theme.of(context).textTheme.bodyText2)
                  ])
            ])));
  }

  Widget _showFormActions() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
          ElevatedButton(
              child: Text('Daftar',
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
                'Sudah terdaftar? Login',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'))
        ]));
  }

void _submit() {
  final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
      print('Username: $_userName, Email: $_emailHP, Password: $_password, Nama: $_nama, Kelamin: $_gender ');
    }
}

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    Uri url = new Uri.https(AppLink.link3,'/auth/local/register');
    http.Response response = await http.post(url,
        body: {"username": _userName, "email": _emailHP, "password": _password, "Fullname": _nama, "Gender":_gender});
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
        content: Text('User $_userName, successfully created!',
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
        appBar: AppBar(title: Text('Daftar akun')),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,  
                      child: Column(children: [
              _showLogo(),
              _showTitle(),
              _showFullnameInput(),
              _showNoHpEmailInput(),
              _showGendersInput(),
              _showUsernameInput(),
              _showPasswordInput(),
              _showTermCondition(),
              _showFormActions()
            ]))))));
  }
  

//   String _validategender(bool male,bool female ) {
//    if(male == false && female == false){
//      return null;
//    }
//    else {
//      return "silakan input jenis kelamin" ;
//    }
//    }
  }
