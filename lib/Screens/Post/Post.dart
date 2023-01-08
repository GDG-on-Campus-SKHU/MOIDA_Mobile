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
  @override
  void initState() {
    super.initState();
    psModel = PostController.getUserPost(widget.id);

    // timeWeather = getTimeWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: psModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var title = snapshot.data!.title;
          var type = snapshot.data!.type;
          var mainContext = snapshot.data!.context;
          return Container(
            width: double.infinity,
            height: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('$title'),
              Text('$type'),
              Text('$mainContext'),
            ]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
