import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Controller/postController.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
import 'package:moida_mobile/Styles/Styles.dart';

import '../../Styles/ColorStyles.dart';

class ModiPost extends StatefulWidget {
  const ModiPost({super.key, required this.id});
  final id;

  @override
  State<ModiPost> createState() => _ModiPostState();
}

class _ModiPostState extends State<ModiPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: modifyPost(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var cheapColor1 = ColorStyle.mainColor;
            var cheapColor2 = ColorStyle.mainColor;
            var cheapColor3 = ColorStyle.mainColor;
            return SafeArea(
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
                            controller: modiPostController.modyTitleController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${snapshot.data!.title}',
                              hintStyle: TextStyle(
                                color: ColorStyle.mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                          padding: const EdgeInsets.all(10),
                          // child: TextField(
                          //   controller: modiPostController.modyTypeController,
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: '${snapshot.data!.type}',
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
                                      modiPostController
                                          .modyTypeController.text = 'STUDY';
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
                                      modiPostController
                                          .modyTypeController.text = 'MEAL';
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
                                      modiPostController
                                          .modyTypeController.text = 'PROJECT';
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
                            controller:
                                modiPostController.modyContextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${snapshot.data!.context}',
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
                          "수정하기",
                          style: Styles.loginBoxText,
                        ),
                      ),
                      onTap: () {
                        modiPostController.modiPostPath(
                            widget.id, snapshot.data!.author);
                        listPost();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PostListPage())));
                      },
                    )
                  ],
                ),
              ),
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(color: ColorStyle.mainColor),
            );
          }
        },
      ),
    );
  }
}
