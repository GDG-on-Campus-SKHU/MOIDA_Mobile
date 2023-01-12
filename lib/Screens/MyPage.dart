import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Controller/postController.dart';
import 'package:moida_mobile/Screens/Login.dart';
import 'package:moida_mobile/Screens/Post/Post.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(automaticallyImplyLeading: false),
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
                      height: 200,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25),
                      //     border: Border.all(
                      //         width: 1, color: ColorStyle.mainColor)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: ColorStyle.mainColor),
                              child: Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('아이디'),
                              Text('${snapshot.data!.username}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('닉네임'),
                              Text('${snapshot.data!.nickname}'),
                            ],
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25),
                    //       border: Border.all(
                    //           width: 1, color: ColorStyle.mainColor)),
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   height: 60,
                    //   color: Colors.white,
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: InkWell(
                    //           onTap: () {},
                    //           child: Container(
                    //               alignment: Alignment.center,
                    //               child: Text('Tab 1')),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(

                    //           onTap: () {},
                    //           child: Container(
                    //               color: Colors.amber,
                    //               alignment: Alignment.center,
                    //               child: Text('Tab 2')),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: InkWell(
                    //           onTap: () {},
                    //           child: Container(
                    //               alignment: Alignment.center,
                    //               child: Text('Tab 3')),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                    Container(
                      height: 500,
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              bottom: TabBar(
                                  indicatorColor: ColorStyle.mainColor,
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: ColorStyle.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          '게시글 (${snapshot.data!.posts!.myContent!.length})',
                                          style: Styles.tabBarText,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 200,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: ColorStyle.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text(
                                          '댓글 (${snapshot.data!.comments!.myContent!.length})',
                                          style: Styles.tabBarText,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            body: TabBarView(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      itemCount: snapshot
                                          .data!.posts!.myContent!.length,
                                      itemBuilder: ((context, index) {
                                        var conId = snapshot
                                            .data!.posts!.myContent![index].id;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: ColorStyle
                                                            .mainColor)),
                                                child: Row(children: [
                                                  Container(
                                                      width: 50,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 0),
                                                      child: Text(typeStringKo(
                                                          snapshot
                                                              .data!
                                                              .posts!
                                                              .myContent![index]
                                                              .type))),
                                                  Container(
                                                    width: 1,
                                                    height: 15,
                                                    color: ColorStyle.mainColor,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 200,
                                                      child: Text(
                                                          '${snapshot.data!.posts!.myContent![index].title}')),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                        '${snapshot.data!.posts!.myContent![index].modifiedDate.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                  )
                                                ]),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          Post(
                                                            id: conId,
                                                          ))));
                                            },
                                          ),
                                        );
                                      })),
                                ),
                                Container(
                                  width: 200,
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      itemCount: snapshot
                                          .data!.comments!.myContent!.length,
                                      itemBuilder: ((context, index) {
                                        return Container(
                                          child: Card(
                                              elevation: 1,
                                              surfaceTintColor: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          '${snapshot.data!.comments!.myContent![index].context}'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                          '${snapshot.data!.comments!.myContent![index].modifiedDate.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        );
                                      })),
                                ),
                              ],
                            )),
                      ),
                    ),
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
