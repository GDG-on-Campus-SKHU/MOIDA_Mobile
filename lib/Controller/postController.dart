import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'authController.dart';

class getPostList {
  static Future getPost() async {
    const url = 'http://moida-skhu.duckdns.org/post/list';

    String? token = await storage.read(key: 'Token');

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response.statusCode == 200) {
      print(token);
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

class writePostController {
  static TextEditingController titleController =
      TextEditingController(); //titleController
  static TextEditingController typeController =
      TextEditingController(); //typeController
  static TextEditingController contextController =
      TextEditingController(); //contextController
  static Future postWrite() async {
    const url = 'http://moida-skhu.duckdns.org/post/new';

    String? token = await storage.read(key: 'Token');

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          "title": titleController.text,
          "type": typeController.text,
          "context": contextController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
