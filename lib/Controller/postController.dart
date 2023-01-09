import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'authController.dart';

class getPostList {
  static Future getPost() async {
    const url = 'http://moida-skhu.duckdns.org/post/list';

    String? token = await storage.read(key: 'Token');

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response.statusCode == 200) {
      print(token);
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

class writePostController {
  static TextEditingController titleController =
      TextEditingController(); //titleController
  static TextEditingController typeController =
      TextEditingController(); //typeController
  static TextEditingController contextController =
      TextEditingController(); //contextController
  static Future postWrite() async {
    const url = 'http://moida-skhu.duckdns.org/post/new';

    String? token = await storage.read(key: 'Token');

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          "title": titleController.text,
          "type": typeController.text,
          "context": contextController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

/**게시글 상세 정보 */
class PostController {
  static Future<PostModel> getUserPost(id) async {
    String? token = await storage.read(key: 'Token');

    var url = 'http://moida-skhu.duckdns.org/post/${id}';
    PostModel postModel;

    var response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ${token}'},
    );

    print(response.body);
    var data = json.decode(response.body);
    postModel = PostModel(
        title: data['title'], type: data['type'], context: data['context']);
    return postModel;
  }
}

/**게시글 상세 정보 모델 클래스 */
class PostModel {
  final String title; //현재 온도
  final String type; //최저 온도
  final String context; //
  PostModel({
    required this.title,
    required this.type,
    required this.context,
  });
}

/**게시글 리스트 */
Future<PostList> listPost() async {
  const url = 'http://moida-skhu.duckdns.org/post/list';

  String? token = await storage.read(key: 'Token');

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  if (response.statusCode == 200) {
    print(token);
    print(response.body);
  } else {
    print(response.body);
  }

  final jsonResponse = json.decode(response.body);

  return new PostList.fromJson(jsonResponse);
}

/**게시글 리스트 모델 클래스 */
class PostList {
  //게시물 리스트 모델 클래스
  List<Content>? content;

  PostList({this.content});

  PostList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['postList'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? author;
  String? title;
  String? type;
  String? context;
  late int id;

  Content({this.author, this.title, this.type, this.context});
  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    type = json['type'];
    context = json['context'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['type'] = this.type;
    data['context'] = this.context;
    return data;
  }
}

/**댓글 조회, 등록 클래스 */
class PostComment {
  static TextEditingController commentController =
      TextEditingController(); //commentController
  static Future commentWrite(id) async {
    /**댓글 등록 */
    var url = 'http://moida-skhu.duckdns.org/post/${id}/comments/new';

    String? token = await storage.read(key: 'Token');
    String? userID = await storage.read(key: 'userID');

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          "postId": id,
          "writer": userID,
          "context": commentController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }

  static Future<CommentList> commentRead(id) async {
    /**댓글 조회 */
    var url = 'http://moida-skhu.duckdns.org/post/${id}/comments';

    String? token = await storage.read(key: 'Token');
    String? userID = await storage.read(key: 'userID');

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token}',
        "Content-Type": "application/json",
        'Charset': 'utf-8',
      },
    );
    print('댓글 목록 \n${response.body}');

    final jsonResponse = json.decode(response.body); //받은 정보를 json형태로 decode
    CommentList commentList = CommentList.fromJson(jsonResponse);

    return commentList;
  }
}

class CommentList {
  List<userComment> comments;

  CommentList({
    required this.comments,
  });

  factory CommentList.fromJson(List<dynamic> json) {
    List<userComment> commentsList = <userComment>[];
    commentsList = json.map((i) => userComment.fromJson(i)).toList();

    return new CommentList(comments: commentsList);
  }
}

class userComment {
  String? writer;
  String? context;

  userComment({
    this.writer,
    this.context,
  });
  factory userComment.fromJson(Map<String, dynamic> json) {
    return new userComment(
      writer: json['writer'],
      context: json['context'],
    );
  }
}
