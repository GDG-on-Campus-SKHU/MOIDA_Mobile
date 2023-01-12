import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Controller/postController.dart';
import 'package:moida_mobile/Screens/Login.dart';
import 'package:moida_mobile/Styles/ColorStyles.dart';
import 'package:moida_mobile/Styles/Styles.dart';
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
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border:
                          Border.all(width: 1, color: ColorStyle.mainColor)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                      )
                    ],
                  ),
                ),
                Text('${snapshot.data!.username}'),
                Text('${snapshot.data!.nickname}'),
                Container(
                  height: 500,
                  child: ListView.builder(
                      itemCount: snapshot.data!.posts!.myContent!.length,
                      itemBuilder: ((context, index) {
                        return Text(
                            '${snapshot.data!.posts!.myContent![index].title}');
                      })),
                )
              ]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorStyle.mainColor,
            ),
          );
        }
      },
    )));
  }
}
