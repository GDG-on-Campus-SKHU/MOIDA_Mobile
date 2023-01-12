import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/postController.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
import 'package:moida_mobile/Styles/Styles.dart';

import '../../Styles/ColorStyles.dart';

class WritePost extends StatefulWidget {
  const WritePost({super.key});

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  var cheapColor1 = ColorStyle.mainColor;
  var cheapColor2 = ColorStyle.mainColor;
  var cheapColor3 = ColorStyle.mainColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1,
                      color: ColorStyle.mainColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: TextField(
                      controller: writePostController.titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          color: ColorStyle.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,

                // child: TextField(
                //   controller: writePostController.typeController,
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     hintText: 'Type',
                //     hintStyle: TextStyle(
                //       color: ColorStyle.mainColor,
                //     ),
                //   ),
                // ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: GestureDetector(
                        child: Container(
                          width: 65,
                          alignment: Alignment.center,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: cheapColor1),
                          child: Text(
                            'STUDY',
                            style: Styles.typeBoxText,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            writePostController.typeController.text = 'STUDY';
                            cheapColor1 = ColorStyle.selectColor;
                            cheapColor2 = ColorStyle.mainColor;
                            cheapColor3 = ColorStyle.mainColor;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Container(
                          width: 65,
                          alignment: Alignment.center,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: cheapColor2),
                          child: Text(
                            'MEAL',
                            style: Styles.typeBoxText,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            writePostController.typeController.text = 'MEAL';
                            cheapColor1 = ColorStyle.mainColor;
                            cheapColor2 = ColorStyle.selectColor;
                            cheapColor3 = ColorStyle.mainColor;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Container(
                          width: 80,
                          alignment: Alignment.center,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: cheapColor3),
                          child: Text(
                            'PROJECT',
                            style: Styles.typeBoxText,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            writePostController.typeController.text = 'PROJECT';
                            cheapColor1 = ColorStyle.mainColor;
                            cheapColor2 = ColorStyle.mainColor;
                            cheapColor3 = ColorStyle.selectColor;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: 1,
                      color: ColorStyle.mainColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: writePostController.contextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Context',
                        hintStyle: TextStyle(
                          color: ColorStyle.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorStyle.mainColor),
                  child: Text(
                    "작성하기",
                    style: Styles.loginBoxText,
                  ),
                ),
                onTap: () {
                  writePostController.postWrite();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PostListPage())));
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
