import 'package:flutter/material.dart';
import 'package:moida_mobile/Screens/Login.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
import 'Controller/authController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: storage.readAll() == '' ? PostList() : Login(),
    );
  }
}
