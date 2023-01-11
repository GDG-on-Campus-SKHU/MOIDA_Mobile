import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Screens/Post/WritePost.dart';

import '../../Controller/postController.dart';

class Post extends StatefulWidget {
  const Post({super.key, required this.id});
  final id;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late Future<PostModel> psModel;
  var commentText = '';
  // FToast? fToast;
  @override
  void initState() {
    super.initState();
    psModel = PostController.getUserPost(widget.id);

    // fToast = FToast();
    // fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: psModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var title = snapshot.data!.title;
          var type = snapshot.data!.type;
          var mainContext = snapshot.data!.context;
          var user = snapshot.data!.author;
          // var commentId = snapshot.data
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  /**게시글 상세 */
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.amber)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('$title'),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.amber)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('$user'),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.amber)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('$type'),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 500,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.amber)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('$mainContext'),
                            )),
                        Container(
                          //댓글 조회
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 500,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.amber)),
                          child: FutureBuilder(
                            future: PostComment.commentRead(widget.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    /**댓글 */
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data! == null
                                        ? 0
                                        : snapshot.data!.comments.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            Card(
                                              elevation: 1,
                                              surfaceTintColor: Colors.white,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        '${snapshot.data!.comments[index].writer}'),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        '${snapshot.data!.comments[index].context}'),
                                                  ),
                                                  Container(
                                                      /**대댓글 작성 */
                                                      alignment:
                                                          Alignment.topRight,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: IconButton(
                                                          onPressed: (() {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    title: Text(
                                                                        "대댓글 작성"),
                                                                    content: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          TextField(
                                                                              controller: PostChildComment.childCommentController,
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: '대댓글',
                                                                                hintStyle: TextStyle(
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ))
                                                                        ]),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              (() {
                                                                            PostChildComment.childCommentWrite(widget.id,
                                                                                snapshot.data!.comments[index].id);
                                                                            Navigator.pop(context);
                                                                            setState(() {
                                                                              psModel = PostController.getUserPost(widget.id);
                                                                            });
                                                                          }),
                                                                          child:
                                                                              Text('대댓글 작성'))
                                                                    ],
                                                                  );
                                                                });
                                                          }),
                                                          icon: Icon(
                                                              Icons.message))),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              /**대댓글 위젯 */
                                              height: 200,
                                              child: FutureBuilder(
                                                future: PostComment.commentRead(
                                                    widget.id),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return ListView.builder(
                                                        itemCount: snapshot
                                                                    .data!
                                                                    .comments[
                                                                        index]
                                                                    .childComments ==
                                                                null
                                                            ? 0
                                                            : snapshot
                                                                .data!
                                                                .comments[index]
                                                                .childComments!
                                                                .length,
                                                        itemBuilder:
                                                            ((context, ind) {
                                                          return Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    width: 30,
                                                                    child: Transform
                                                                        .scale(
                                                                      scaleX:
                                                                          -1,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_back_sharp,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    )),
                                                                Container(
                                                                  width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.9 -
                                                                      40,
                                                                  child: Card(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              Text(
                                                                            '${snapshot.data!.comments[index].childComments![ind].writer}',
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              Text(
                                                                            '${snapshot.data!.comments[index].childComments![ind].context}',
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              Text(
                                                                            '${snapshot.data!.comments[index].childComments![ind].modifiedDate}',
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }));
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }));
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber,
              child: Icon(Icons.message),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        alignment: Alignment.center,
                        title: Text("댓글 작성"),
                        content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                  controller: PostComment.commentController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '댓글',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ))
                            ]),
                        actions: [
                          TextButton(
                              onPressed: (() {
                                PostComment.commentWrite(widget.id);
                                Navigator.pop(context);
                                setState(() {
                                  psModel =
                                      PostController.getUserPost(widget.id);
                                });
                              }),
                              child: Text('댓글 작성'))
                        ],
                      );
                    });
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
