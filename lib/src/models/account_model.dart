import 'dart:convert';
import 'package:crypto/crypto.dart';

class AccountModel {
  String account;
  String password;

  AccountModel({this.account, this.password});

  String hashPassword() {
    return md5.convert(utf8.encode(password)).toString();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["studentAccount"] = account;
    json["studentPassword"] = password;
    return json;
  }
}