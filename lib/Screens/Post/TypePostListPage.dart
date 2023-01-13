import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moida_mobile/Screens/Post/Post.dart';
import 'package:moida_mobile/Styles/Styles.dart';

import '../../Controller/postController.dart';
import '../../Styles/ColorStyles.dart';

class TypePostListPage extends StatefulWidget {
  const TypePostListPage({super.key});

  @override
  State<TypePostListPage> createState() => _TypePostListPageState();
}

class _TypePostListPageState extends State<TypePostListPage> {
  Future<PostList> studyPostList = listTypePost('STUDY', 0);
  Future<PostList> mealPostList = listTypePost('MEAL', 0);
  Future<PostList> projectPostList = listTypePost('PROJECT', 0);
  var studyPostNum = 0;
  var mealPostNum = 0;
  var projectPostNum = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Colors.purple,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorStyle.mainColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        '공부',
                        style: Styles.tabBarText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ColorStyle.mainColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        '혼밥',
                        style: Styles.tabBarText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: ColorStyle.mainColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        '팀플',
                        style: Styles.tabBarText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FutureBuilder(
                    future: studyPostList,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.content!.length,
                                  itemBuilder: ((context, index) {
                                    var title =
                                        snapshot.data!.content![index].title;
                                    var date = snapshot
                                        .data!.content![index].createdDate;
                                    var id = snapshot.data!.content![index].id;
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              width: 1,
                                              color: ColorStyle.mainColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text('$title'),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 1,
                                                    height: 15,
                                                    color: ColorStyle.mainColor,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                        '${date.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => Post(
                                                      id: id,
                                                    ))));
                                      },
                                    );
                                  })),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_left,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '이전 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (studyPostNum != 0) {
                                          studyPostNum = studyPostNum - 1;
                                          studyPostList = listTypePost(
                                              'STUDY', studyPostNum);

                                          print('$studyPostNum');
                                        } else {
                                          FToast().showToast(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color:
                                                          ColorStyle.mainColor),
                                                  child: Text(
                                                    '처음 페이지 입니다.',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        }
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '다음 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (snapshot.data!.last == false) {
                                          studyPostNum = studyPostNum + 1;
                                          studyPostList = listTypePost(
                                              'STUDY', studyPostNum);

                                          print('$studyPostList');
                                        } else {
                                          FToast().showToast(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color:
                                                          ColorStyle.mainColor),
                                                  child: Text(
                                                    '마지막 페이지 입니다.',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
                FutureBuilder(
                    future: mealPostList,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.content!.length,
                                  itemBuilder: ((context, index) {
                                    var title =
                                        snapshot.data!.content![index].title;
                                    var date = snapshot
                                        .data!.content![index].createdDate;
                                    var id = snapshot.data!.content![index].id;
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              width: 1,
                                              color: ColorStyle.mainColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text('$title'),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 1,
                                                    height: 15,
                                                    color: ColorStyle.mainColor,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                        '${date.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => Post(
                                                      id: id,
                                                    ))));
                                      },
                                    );
                                  })),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_left,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '이전 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (mealPostNum != 0) {
                                          mealPostNum = mealPostNum - 1;
                                          mealPostList =
                                              listTypePost('MEAL', mealPostNum);

                                          print('$projectPostNum');
                                        } else {
                                          FToast().showToast(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color:
                                                          ColorStyle.mainColor),
                                                  child: Text(
                                                    '처음 페이지 입니다.',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        }
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '다음 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (snapshot.data!.last == false) {
                                          mealPostNum = mealPostNum + 1;
                                          mealPostList =
                                              listTypePost('MEAL', mealPostNum);

                                          print('$projectPostList');
                                        } else {
                                          FToast().showToast(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      color:
                                                          ColorStyle.mainColor),
                                                  child: Text(
                                                    '마지막 페이지 입니다.',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
                FutureBuilder(
                    future: projectPostList,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.content!.length,
                                  itemBuilder: ((context, index) {
                                    var title =
                                        snapshot.data!.content![index].title;
                                    var date = snapshot
                                        .data!.content![index].createdDate;
                                    var id = snapshot.data!.content![index].id;
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              width: 1,
                                              color: ColorStyle.mainColor,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text('$title'),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 1,
                                                    height: 15,
                                                    color: ColorStyle.mainColor,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                        '${date.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) => Post(
                                                      id: id,
                                                    ))));
                                      },
                                    );
                                  })),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_left,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '이전 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (projectPostNum != 0) {
                                          projectPostNum = projectPostNum - 1;
                                          projectPostList = listTypePost(
                                              'PROJECT', projectPostNum);

                                          print('$projectPostNum');
                                        } else {
                                          FToast().showToast(
                                              child: Text('처음 페이지 입니다.'));
                                        }
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 120,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: ColorStyle.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '다음 페이지',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (snapshot.data!.last == false) {
                                          projectPostNum = projectPostNum + 1;
                                          projectPostList = listTypePost(
                                              'PROJECT', projectPostNum);

                                          print('$projectPostList');
                                        } else {
                                          FToast().showToast(
                                              child: Text('마지막 페이지 입니다.'));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
              ],
            )));
  }
}
