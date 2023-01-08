import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/postController.dart';

class WritePost extends StatefulWidget {
  const WritePost({super.key});

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: writePostController.titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: writePostController.typeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: writePostController.contextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Context',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: 140,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
              child: Text("작성하기"),
            ),
            onTap: () {
              writePostController.postWrite();
            },
          )
        ],
      )),
    );
  }
}
