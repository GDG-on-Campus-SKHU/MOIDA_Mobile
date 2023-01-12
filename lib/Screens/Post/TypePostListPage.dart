import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                    future: listTypePost('study'),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.content!.length,
                            itemBuilder: ((context, index) {
                              var title = snapshot.data!.content![index].title;
                              var date =
                                  snapshot.data!.content![index].createdDate;
                              var id = snapshot.data!.content![index].id;
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
                            }));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
                FutureBuilder(
                    future: listTypePost('meal'),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.content!.length,
                            itemBuilder: ((context, index) {
                              var title = snapshot.data!.content![index].title;
                              var date =
                                  snapshot.data!.content![index].createdDate;
                              var id = snapshot.data!.content![index].id;
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
                            }));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
                FutureBuilder(
                    future: listTypePost('project'),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.content!.length,
                            itemBuilder: ((context, index) {
                              var title = snapshot.data!.content![index].title;
                              var date =
                                  snapshot.data!.content![index].createdDate;
                              var id = snapshot.data!.content![index].id;
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
                            }));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
              ],
            )));
  }
}
