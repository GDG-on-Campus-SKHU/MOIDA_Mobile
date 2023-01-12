import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    listPost();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        setState(() {
          listPost();
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //       icon: Icon(Icons.person),
        //       onPressed: () {
        //         getUserId();
        //       },
        //     )
        //   ],
        // ),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/moidaLogo.png'))),
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text('지금 바로 참가할 수 있는 모임들'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: GestureDetector(
                                child: Text(
                                  '카테고리별 보기',
                                  style: TextStyle(color: Colors.blue),
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
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Divider(
                            color: ColorStyle.mainColor, thickness: 2.0))
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: FutureBuilder(
                    future: listPost(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.content!.length,
                            itemBuilder: ((context, index) {
                              var contId = snapshot.data!.content![index].id;
                              var title = snapshot.data!.content![index].title;
                              var type = snapshot.data!.content![index].type;
                              var mainContext =
                                  snapshot.data!.content![index].context;
                              var editDate = snapshot
                                  .data!.content![index].createdDate
                                  .toString()
                                  .substring(2, 10);
                              return GestureDetector(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 50,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Text(typeStringKo(type))),
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
                                          padding: const EdgeInsets.all(10.0),
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
                            }));
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
    case 'project':
      return '팀플';
    case 'study':
      return '공부';

    default:
      return '잘못';
  }
}
