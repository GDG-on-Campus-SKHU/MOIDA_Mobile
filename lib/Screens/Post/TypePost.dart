import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Controller/postController.dart';

class TypePost extends StatefulWidget {
  const TypePost({super.key});

  @override
  State<TypePost> createState() => _TypePostState();
}

class _TypePostState extends State<TypePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: IconButton(
          onPressed: (() {
            listTypePost();
          }),
          icon: Icon(Icons.abc)),
    ));
  }
}
