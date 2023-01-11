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
      home: storage.readAll() == '' ? PostListPage() : Login(),
    );
  }
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
//         home: LoginController.loginUser() == true ? PostListPage() : Login()
//         // await LoginController.loginUser()  ? PostListPage() : Login(),

//         );
//   }
// }
