import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class UserReg {
  dynamic statusCode;
  bool success;
  List<String> messages;
  Data data;

  UserReg({@required this.statusCode,@required this.success,this.messages,@required this.data});

  factory UserReg.fromJson(Map <String,dynamic> json){
    var messageFromJson = json["message"];
    List<String> messageList = messageFromJson.cast<String>();
    return UserReg(
      statusCode : json["statusCode"],
      success : json["success"],
      messages: messageList,
      data: Data.fromJson(json["data"])

    );
  }
}

class Data {
  String headerkey;
  List<Users> user;

  Data({@required this.headerkey,@required this.user});

  factory Data.fromJson(Map <String,dynamic> json){
    return Data(
      headerkey: json["header key"],
      user: json["users"] == null ? null: List<Users>.from(json["users"].map((x) => Users.fromJson(x)))
    );
  }
}

class Users {
  dynamic id;
  String usernames;
  String name;
  String phone;
  String address;

  Users({@required this.id,@required this.usernames,@required this.name,@required this.phone,@required this.address});

  factory Users.fromJson(Map <String,dynamic> json){
    return Users(
      id : json['id'],
      usernames: json['usernames'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

}