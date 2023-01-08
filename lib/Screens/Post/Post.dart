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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: PostController.getUserPost(widget.id),
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [Text(snapshot.data)]),
        );
      },
    ));
  }
}
