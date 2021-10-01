import 'package:meta/meta.dart';

class User{
  dynamic id;
  String username;
  String email;
  String fullname;
  String gender;
  String jwt;
  String cartId;

  User({ @required this.id, @required this.username,@required this.email, this.fullname,this.gender, @required this.jwt,@required this.cartId});

  factory User.fromJson(Map <String,dynamic> json){
    return User(
      id : json['id'],
      username : json['username'],
      email : json['email'],
      fullname : json['Fullname'],
      gender : json['Gender'],
      jwt : json['jwt'],
      cartId : json['cart_id']
    );
  }
}