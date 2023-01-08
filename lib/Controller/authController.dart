import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class SigninController {
  //회원가입 클래스
  TextEditingController usernameController =
      TextEditingController(); //usernameController
  TextEditingController passwordController =
      TextEditingController(); //Password Controller
  TextEditingController repeatedPasswordController =
      TextEditingController(); //repeatedPasswordController
  TextEditingController nicknameController =
      TextEditingController(); //nicknameController
  Future signinUser() async {
    const url = 'http://moida-skhu.duckdns.org/join';

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
          "repeatedPassword": repeatedPasswordController.text,
          "nickname": nicknameController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

class LoginController {
  //로그인 클래스 & 토큰 관리

  static TextEditingController usernameController =
      TextEditingController(); //usernameController
  static TextEditingController passwordController =
      TextEditingController(); //Password Controller

  static Future<bool> loginUser() async {
    const url = 'http://moida-skhu.duckdns.org/login';
    // http.Response response;
    User userData;
    var data;

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
        }));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print("${response.statusCode}");
      userData = User(
        grantType: data["grantType"],
        accessToken: data["accessToken"],
      );
      String token = userData.accessToken.toString();
      String userID = usernameController.text;
      await storage.write(key: 'userID', value: userID);
      await storage.write(key: 'Token', value: token);
      print(token);
      print(response.body);
      return response.body.isEmpty;
    } else {
      print(response.statusCode);
      return response.body.isEmpty;
    }
  }
}

class UserTokenList {
  //토큰 받아오는 클래스
  List<User>? userToken;

  UserTokenList({this.userToken});

  UserTokenList.fromJson(Map<String, dynamic> json) {
    if (json['week'] != null) {
      userToken = <User>[];
      json['week'].forEach((v) {
        userToken!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userToken != null) {
      data['week'] = this.userToken!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? grantType;
  String? accessToken;

  User({
    this.grantType,
    this.accessToken,
  });
  User.fromJson(Map<String, dynamic> json) {
    grantType = json['grantType'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grantType'] = this.grantType;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
