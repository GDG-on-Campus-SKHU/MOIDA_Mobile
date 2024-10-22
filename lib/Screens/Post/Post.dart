import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Screens/Post/ModiPost.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
import 'package:moida_mobile/Screens/Post/WritePost.dart';
import 'package:moida_mobile/Styles/Styles.dart';

import '../../Controller/postController.dart';
import '../../Styles/ColorStyles.dart';

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
    getUserId();
    // PostComment.commentController.clear();
    // modifyCommentsClass.modyCommentsController.clear();
    // fToast = FToast();
    // fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserId(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userId = snapshot.data!.username;

          return Container(
            height: double.infinity,
            child: FutureBuilder(
              future: psModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var title = snapshot.data!.title;
                  var type = snapshot.data!.type;
                  var mainContext = snapshot.data!.context;
                  var user = snapshot.data!.author;
                  var nickName = snapshot.data!.nickname;

                  var userToken = storage.read(key: 'Token');

                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: SafeArea(
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            /**게시글 상세 */
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorStyle.mainColor,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 250,
                                                alignment: Alignment.topLeft,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  '$title',
                                                  style: Styles.postHeaderText,
                                                ),
                                              ),
                                              Container(
                                                child: userId == user
                                                    ? Column(
                                                        children: [
                                                          IconButton(
                                                              onPressed: (() {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            '게시글을 수정하시겠습니까?'),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: ((context) => ModiPost(
                                                                                              id: widget.id,
                                                                                            ))));
                                                                              }),
                                                                              child: Text('수정')),
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                Navigator.pop(context);
                                                                              }),
                                                                              child: Text('취소'))
                                                                        ],
                                                                      );
                                                                    }));
                                                              }),
                                                              icon: Icon(
                                                                Icons.edit,
                                                                color: ColorStyle
                                                                    .mainColor,
                                                              )),
                                                          IconButton(
                                                              onPressed: (() {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        ((context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            '게시글을 삭제하시겠습니까?'),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                deletePost(widget.id);

                                                                                Navigator.push(context, MaterialPageRoute(builder: ((context) => PostListPage())));
                                                                              }),
                                                                              child: Text('삭제')),
                                                                          TextButton(
                                                                              onPressed: (() {
                                                                                Navigator.pop(context);
                                                                              }),
                                                                              child: Text('취소'))
                                                                        ],
                                                                      );
                                                                    }));
                                                              }),
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: ColorStyle
                                                                    .mainColor,
                                                              )),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Container(
                                                    width: 80,
                                                    alignment: Alignment.center,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: ColorStyle
                                                            .mainColor),
                                                    child: Text(
                                                      '$type',
                                                      style: Styles.typeBoxText,
                                                    )),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text('${nickName}'),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 500,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorStyle.mainColor,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          '$mainContext',
                                          style: Styles.postContextText,
                                        ),
                                      )),
                                  SingleChildScrollView(
                                    child: Container(
                                      //댓글 조회
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 500,

                                      child: FutureBuilder(
                                        future:
                                            PostComment.commentRead(widget.id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                                /**댓글 */
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data! == null
                                                        ? 0
                                                        : snapshot.data!
                                                            .comments.length,
                                                itemBuilder: ((context, index) {
                                                  return Container(
                                                    child: Card(
                                                      elevation: 1,
                                                      surfaceTintColor:
                                                          Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                /**댓글 수정 버튼 */
                                                                Text(
                                                                    '${snapshot.data!.comments[index].nickname}'),
                                                                userId ==
                                                                        snapshot
                                                                            .data!
                                                                            .comments[index]
                                                                            .writer
                                                                    ? Row(
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                modifyCommentsClass.modyCommentsController.clear();
                                                                                showDialog(
                                                                                    context: context,
                                                                                    barrierDismissible: true,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                          title: Text('댓글수정'),
                                                                                          alignment: Alignment.center,
                                                                                          content: Container(
                                                                                            height: 100,
                                                                                            child: SingleChildScrollView(
                                                                                              child: Container(
                                                                                                height: 50,
                                                                                                child: TextField(
                                                                                                    controller: modifyCommentsClass.modyCommentsController,
                                                                                                    decoration: InputDecoration(
                                                                                                      border: InputBorder.none,
                                                                                                      suffixIcon: TextButton(
                                                                                                          onPressed: (() {
                                                                                                            modifyCommentsClass.modifyComments(widget.id, snapshot.data!.comments[index].id);

                                                                                                            Navigator.pop(context);
                                                                                                            setState(() {
                                                                                                              psModel = PostController.getUserPost(widget.id);
                                                                                                            });
                                                                                                          }),
                                                                                                          child: Text('수정')),
                                                                                                      hintText: '${snapshot.data!.comments[index].context}',
                                                                                                      hintStyle: TextStyle(
                                                                                                        color: Colors.black,
                                                                                                      ),
                                                                                                    )),
                                                                                              ),
                                                                                            ),
                                                                                          ));
                                                                                    });
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.edit,
                                                                                size: 20,
                                                                                color: ColorStyle.mainColor,
                                                                              )),
                                                                          IconButton(
                                                                              onPressed: (() {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    barrierDismissible: true,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        alignment: Alignment.center,
                                                                                        content: Container(height: 50, alignment: Alignment.center, child: Text('댓글을 삭제하시겠습니까?')),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                              onPressed: (() {
                                                                                                deleteComments(widget.id, snapshot.data!.comments[index].id);
                                                                                                Navigator.pop(context);
                                                                                                setState(() {
                                                                                                  psModel = PostController.getUserPost(widget.id);
                                                                                                });
                                                                                              }),
                                                                                              child: Text('삭제')),
                                                                                          TextButton(
                                                                                              onPressed: (() {
                                                                                                Navigator.pop(context);
                                                                                              }),
                                                                                              child: Text('취소')),
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              }),
                                                                              icon: Icon(
                                                                                Icons.delete,
                                                                                size: 20,
                                                                                color: ColorStyle.mainColor,
                                                                              ))
                                                                        ],
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              '${snapshot.data!.comments[index].context}',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        10),
                                                                child: GestureDetector(
                                                                    onTap: (() {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              true,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                                alignment: Alignment.center,
                                                                                content: Container(
                                                                                  height: 450,
                                                                                  child: SingleChildScrollView(
                                                                                    child: Column(
                                                                                      children: [
                                                                                        replyContainer(widget.id, index),
                                                                                        Container(
                                                                                          height: 50,
                                                                                          child: TextField(
                                                                                              controller: PostChildComment.childCommentController,
                                                                                              decoration: InputDecoration(
                                                                                                border: InputBorder.none,
                                                                                                suffixIcon: TextButton(
                                                                                                    onPressed: (() {
                                                                                                      PostChildComment.childCommentWrite(widget.id, snapshot.data!.comments[index].id);
                                                                                                      Navigator.pop(context);
                                                                                                      setState(() {
                                                                                                        psModel = PostController.getUserPost(widget.id);
                                                                                                      });
                                                                                                    }),
                                                                                                    child: Text('작성')),
                                                                                                hintText: '대댓글',
                                                                                                hintStyle: TextStyle(
                                                                                                  color: Colors.black,
                                                                                                ),
                                                                                              )),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ));
                                                                          });
                                                                    }),
                                                                    child: snapshot.data!.comments[index].childComments != null
                                                                        ? Text(
                                                                            '+ 답글 달기 [${snapshot.data!.comments[index].childComments!.length}]',
                                                                            style:
                                                                                TextStyle(color: ColorStyle.mainColor),
                                                                          )
                                                                        : Text(
                                                                            '+ 답글 달기 [0]',
                                                                            style:
                                                                                TextStyle(color: ColorStyle.mainColor),
                                                                          )
                                                                    // Icon(
                                                                    //     Icons
                                                                    //         .abc),
                                                                    ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            10),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    '${snapshot.data!.comments[index].createdDate.toString().substring(2, 16).replaceAll('T', ' ')}'),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
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
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: ColorStyle.mainColor,
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
                                          controller:
                                              PostComment.commentController,
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
                                          psModel = PostController.getUserPost(
                                              widget.id);
                                        });
                                      }),
                                      child: Text(
                                        '댓글 작성',
                                        selectionColor: ColorStyle.mainColor,
                                      ))
                                ],
                              );
                            });
                        PostComment.commentController.clear();
                      },
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(
                        color: ColorStyle.mainColor,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: ColorStyle.mainColor,
              ),
            ),
          );
        }
      },
    );
  }
}

/**대댓글 위젯 */
Widget replyContainer(postId, commentIndex) {
  return Container(
    alignment: Alignment.topLeft,
    width: 200,
    /**대댓글 위젯 */
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FutureBuilder(
          future: PostComment.commentRead(postId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: 200,
                height: 350,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:
                        snapshot.data!.comments[commentIndex].childComments ==
                                null
                            ? 0
                            : snapshot.data!.comments[commentIndex]
                                .childComments!.length,
                    itemBuilder: ((context, ind) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: Card(
                                elevation: 1,
                                surfaceTintColor: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        '${snapshot.data!.comments[commentIndex].childComments![ind].nickname}',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        '${snapshot.data!.comments[commentIndex].childComments![ind].context}',
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        '${snapshot.data!.comments[commentIndex].childComments![ind].modifiedDate.toString().substring(2).replaceAll('T', ' ')}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}


// 
// Container(
//                                                         /**대댓글 위젯 */
//                                                         height: 200,
//                                                         child: FutureBuilder(
//                                                           future: PostComment
//                                                               .commentRead(
//                                                                   widget.id),
//                                                           builder: (context,
//                                                               snapshot) {
//                                                             if (snapshot
//                                                                 .hasData) {
//                                                               return ListView
//                                                                   .builder(
//                                                                       itemCount: snapshot.data!.comments[index].childComments ==
//                                                                               null
//                                                                           ? 0
//                                                                           : snapshot
//                                                                               .data!
//                                                                               .comments[
//                                                                                   index]
//                                                                               .childComments!
//                                                                               .length,
//                                                                       itemBuilder:
//                                                                           ((context,
//                                                                               ind) {
//                                                                         return Container(
//                                                                           width:
//                                                                               MediaQuery.of(context).size.width * 0.9,
//                                                                           child:
//                                                                               Row(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.start,
//                                                                             children: [
//                                                                               SizedBox(
//                                                                                   width: 30,
//                                                                                   child: Transform.scale(
//                                                                                     scaleX: -1,
//                                                                                     child: Icon(
//                                                                                       Icons.arrow_back_sharp,
//                                                                                       size: 30,
//                                                                                     ),
//                                                                                   )),
//                                                                               Container(
//                                                                                 width: MediaQuery.of(context).size.width * 0.9 - 40,
//                                                                                 child: Card(
//                                                                                   child: Column(
//                                                                                     children: [
//                                                                                       Container(
//                                                                                         alignment: Alignment.topLeft,
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         child: Text(
//                                                                                           '${snapshot.data!.comments[index].childComments![ind].writer}',
//                                                                                         ),
//                                                                                       ),
//                                                                                       Container(
//                                                                                         alignment: Alignment.topLeft,
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         child: Text(
//                                                                                           '${snapshot.data!.comments[index].childComments![ind].context}',
//                                                                                         ),
//                                                                                       ),
//                                                                                       Container(
//                                                                                         alignment: Alignment.topLeft,
//                                                                                         padding: EdgeInsets.all(10),
//                                                                                         child: Text(
//                                                                                           '${snapshot.data!.comments[index].childComments![ind].modifiedDate.toString().substring(2).replaceAll('T', ' ')}',
//                                                                                         ),
//                                                                                       ),
//                                                                                     ],
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         );
//                                                                       }));
//                                                             } else {
//                                                               return Center(
//                                                                 child:
//                                                                     CircularProgressIndicator(),
//                                                               );
//                                                             }
//                                                           },
//                                                         ),
//                                                       )