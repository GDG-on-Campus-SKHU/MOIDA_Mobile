import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class noticeController {
  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController contextController = TextEditingController();
  Future noticePost() async {
    const url = 'http://moida-skhu.duckdns.org/post/new';

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "title": titleController.text,
          "type": typeController.text,
          "context": contextController.text,
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
