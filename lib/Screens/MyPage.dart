import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Controller/postController.dart';
import 'package:moida_mobile/Screens/Login.dart';
import 'package:moida_mobile/main.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPage'),
        actions: [
          IconButton(
              onPressed: () {
                storage.deleteAll();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Login())));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [Icon(Icons.person_outline), Text('data')],
                ),
              ),
              IconButton(
                  onPressed: () {
                    // userPostController.getUserPost();
                  },
                  icon: Icon(Icons.padding))
            ],
          )),
    );
  }
}
