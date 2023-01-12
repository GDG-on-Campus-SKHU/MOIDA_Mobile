import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Controller/postController.dart';

class TypePostListPage extends StatefulWidget {
  const TypePostListPage({super.key});

  @override
  State<TypePostListPage> createState() => _TypePostListPageState();
}

class _TypePostListPageState extends State<TypePostListPage> {
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
