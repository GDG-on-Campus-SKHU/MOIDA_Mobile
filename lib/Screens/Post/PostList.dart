import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Screens/MyPage.dart';
import 'package:moida_mobile/Screens/Post/Post.dart';
import 'package:moida_mobile/Screens/Post/WritePost.dart';
import '../../Controller/postController.dart';
import '../../Styles/ColorStyles.dart';
import 'TypePostListPage.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  Future<PostList> postListView = listPost(0);
  var postNumber = 0;
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    var postLast;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        writePostController.titleController.clear();
        writePostController.typeController.clear();
        writePostController.contextController.clear();
        setState(() {
          listPost(postNumber);
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/moidaLogo.png')),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 150,
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => MyPage())));
                            }),
                            icon: Icon(
                              Icons.person,
                              color: ColorStyle.mainColor,
                            )),
                      ),
                      Container(
                          alignment: Alignment.bottomCenter,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text('지금 바로 참가할 수 있는 모임들'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: GestureDetector(
                                  child: Text(
                                    '카테고리별 보기',
                                    style:
                                        TextStyle(color: ColorStyle.mainColor),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                TypePostListPage())));
                                  },
                                ),
                              ),
                            ],
                          )),
                      Container(
                          alignment: Alignment.bottomCenter,
                          height: 170,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Divider(
                              color: ColorStyle.mainColor, thickness: 2.0))
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: FutureBuilder(
                      future: postListView,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.58,
                                child: ListView.builder(
                                    itemCount: snapshot.data!.content!.length,
                                    itemBuilder: ((context, index) {
                                      var contId =
                                          snapshot.data!.content![index].id;
                                      var title =
                                          snapshot.data!.content![index].title;
                                      var type =
                                          snapshot.data!.content![index].type;
                                      var mainContext = snapshot
                                          .data!.content![index].context;
                                      var editDate = snapshot
                                          .data!.content![index].createdDate
                                          .toString()
                                          .substring(2, 10);

                                      return GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
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
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 50,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    child: Text(
                                                        typeStringKo(type))),
                                                Container(
                                                  width: 1,
                                                  height: 15,
                                                  color: ColorStyle.mainColor,
                                                ),
                                                Container(
                                                    alignment: Alignment.center,
                                                    width: 200,
                                                    child: Text('${title}')),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Text('${editDate}'),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) => Post(
                                                        id: contId,
                                                      ))));
                                        },
                                      );
                                    })),
                              ),
                              SizedBox(
                                height: 2,
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (postNumber != 0) {
                                            postNumber = postNumber - 1;
                                            postListView = listPost(postNumber);

                                            print('$postNumber');
                                          } else {
                                            FToast().showToast(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color: ColorStyle
                                                            .mainColor),
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
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                            postNumber = postNumber + 1;
                                            postListView = listPost(postNumber);

                                            print('$postNumber');
                                          } else {
                                            FToast().showToast(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color: ColorStyle
                                                            .mainColor),
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
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorStyle.mainColor,
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorStyle.mainColor,
            child: Icon(Icons.note_add),
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => WritePost())));
            })),
      ),
    );
  }
}

String typeStringKo(typeData) {
  switch (typeData) {
    case 'meal':
      return '혼밥';
    case 'MEAL':
      return '혼밥';
    case 'project':
      return '팀플';
    case 'PROJECT':
      return '팀플';
    case 'study':
      return '공부';
    case 'STUDY':
      return '공부';

    default:
      return '잘못';
  }
}
