import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Screens/Post/WritePost.dart';
import '../../Controller/postController.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
        icon: Icon(Icons.abc),
        onPressed: () {
          getPostList.getPost();
        },
      )),
      floatingActionButton: FloatingActionButton(onPressed: (() {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => WritePost())));
      })),
    );
  }
}
