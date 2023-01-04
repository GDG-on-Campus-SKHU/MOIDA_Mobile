import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SigninController {
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
  TextEditingController usernameController =
      TextEditingController(); //usernameController
  TextEditingController passwordController =
      TextEditingController(); //Password Controller

  Future<bool> loginUser() async {
    const url = 'http://moida-skhu.duckdns.org/login';

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
        }));
    if (response.statusCode == 200) {
      print(response.body.isEmpty);
      return response.body.isEmpty;
    } else {
      print(response.body.isEmpty);
      return response.body.isEmpty;
    }
  }
}
