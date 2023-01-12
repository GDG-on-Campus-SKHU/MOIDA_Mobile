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
        body: SafeArea(
            child: FutureBuilder(
      future: userDataPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(children: [
              Text('${snapshot.data!.username}'),
              Text('${snapshot.data!.nickname}'),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: snapshot.data!.posts!.myContent!.length,
                    itemBuilder: ((context, index) {
                      return Text('${snapshot.data!.posts!.myContent![index]}');
                    })),
              )
            ]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    )));
  }
}
