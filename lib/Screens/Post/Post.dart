import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.amber)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('$title'),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.amber)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('$type'),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.amber)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('$mainContext'),
                    )),
                Container(
                  //댓글 등록
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.amber)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: PostComment.commentController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '댓글',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                              onPressed: (() {
                                if (commentText == '') {
                                  Text('data');
                                } else {
                                  PostComment.commentWrite(widget.id);
                                }
                              }),
                              icon: Icon(Icons.add))),
                      onChanged: ((value) {
                        setState(() {
                          commentText = value;
                        });
                      }),
                    ),
                  ),
                ),
                Container(
                  //댓글 조회
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.amber)),

                  child: FutureBuilder(
                    future: PostComment.commentRead(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data! == null
                                ? 0
                                : snapshot.data!.comments.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          '${snapshot.data!.comments[index].writer}'),
                                      Text(
                                          '${snapshot.data!.comments[index].context}'),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  AlertDialog();
                                },
                              );
                            }));
                      } else {
                        return Center(
                          child: Text('no has data'),
                        );
                      }
                    },
                  ),
                ),
              ]),
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
