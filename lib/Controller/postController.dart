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
      headers: {
        'Authorization': 'Bearer ${token}',
        "Content-Type": "application/json",
        'Charset': 'utf-8',
      },
    );

    print('게시글 상세 : ${response.body}');
    var data = json.decode(utf8.decode(response.bodyBytes));
    postModel = PostModel(
        author: data['author'],
        title: data['title'],
        type: data['type'],
        context: data['context'],
        nickname: data['nickname']);
    return postModel;
  }
}

/**게시글 상세 정보 모델 클래스 */
class PostModel {
  final String title; //게시글 제목
  final String type; //게시글 태그
  final String context; //게시글 내용
  final String author; //게시글 작성자
  final String nickname; //작성자 닉네임
  PostModel(
      {required this.title,
      required this.type,
      required this.context,
      required this.author,
      required this.nickname});
}

/**게시글 리스트 */
Future<PostList> listPost(number) async {
  var url = 'http://moida-skhu.duckdns.org/post/list/${number}';

  String? token = await storage.read(key: 'Token');

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  if (response.statusCode == 200) {
    print(token);
    print('게시글 목록${utf8.decode(response.bodyBytes)}');
  } else {
    print(response.body);
  }

  final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

  return new PostList.fromJson(jsonResponse);
}

/**게시글 리스트 모델 클래스 */
class PostList {
  //게시물 리스트 모델 클래스
  List<Content>? content;
  bool? last;

  PostList({this.content, this.last});

  PostList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['postList'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['last'] = this.last;
    return data;
  }
}

class Content {
  String? author;
  String? title;
  String? type;
  String? context;
  String? createdDate;
  String? nickname;

  late int id;

  Content({
    this.author,
    this.title,
    this.type,
    this.context,
    this.createdDate,
    this.nickname,
  });
  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    type = json['type'];
    context = json['context'];
    createdDate = json['createdDate'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['type'] = this.type;
    data['context'] = this.context;
    data['createdDate'] = this.createdDate;
    data['nickname'] = this.nickname;

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

  static Future<CommentList?> commentRead(id) async {
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
    print('댓글 목록 ${response.body}');
    CommentList? commentList;
    final jsonResponse =
        json.decode(utf8.decode(response.bodyBytes)); //받은 정보를 json형태로 decode
    if (response.statusCode == 200) {
      commentList = CommentList.fromJson(jsonResponse);
    } else {
      commentList = null;
    }

    return commentList;
  }
}

/**댓글 리스트 모델 */
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
// class CommentList{
//   List<userComment> comments;
//   CommentList({
//     required this.comments,
//   });

//   factory CommentList.fromJson(Map<String, dynamic> json) {
//     this.comments = json['comments'].entries.map((e) => userComment.fromJson(e.value)).toList();
//   }
// }

/**댓글 구성 요소 모델 */
class userComment {
  String? writer;
  String? context;
  String? nickname;
  int? id;
  List<ChildComments>? childComments;
  String? createdDate;

  userComment(
      {this.writer, this.context, this.id, this.childComments, this.nickname});
  // factory userComment.fromJson(Map<String, dynamic> json) {
  //   return new userComment(
  //       writer: json['writer'], context: json['context'], id: json['id']);
  // }
  userComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];

    writer = json['writer'];
    context = json['context'];
    createdDate = json['createdDate'];

    if (json['childComments'] != null) {
      childComments = <ChildComments>[];
      json['childComments'].forEach((v) {
        childComments!.add(new ChildComments.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['writer'] = this.writer;
    data['context'] = this.context;

    if (this.childComments != null) {
      data['childComments'] =
          this.childComments!.map((v) => v.toJson()).toList();
    }
    data['createdDate'] = this.createdDate;

    return data;
  }
}

class ChildComments {
  int? id;
  int? postId;
  String? writer;
  String? context;
  String? nickname;
  int? parentCommentId;

  String? createdDate;
  String? modifiedDate;

  ChildComments(
      {this.id,
      this.postId,
      this.writer,
      this.context,
      this.parentCommentId,
      this.createdDate,
      this.modifiedDate,
      this.nickname});

  ChildComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    writer = json['writer'];
    context = json['context'];
    parentCommentId = json['parentCommentId'];
    nickname = json['nickname'];

    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['writer'] = this.writer;
    data['context'] = this.context;
    data['parentCommentId'] = this.parentCommentId;
    data['nickname'] = this.nickname;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}

class PostChildComment {
  static TextEditingController childCommentController =
      TextEditingController(); //commentController
  static Future childCommentWrite(postId, index) async {
    /**댓글 등록 */
    var url = 'http://moida-skhu.duckdns.org/post/${postId}/comments/new';

    String? token = await storage.read(key: 'Token');
    String? userID = await storage.read(key: 'userID');

    var response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          "postId": postId,
          "writer": userID,
          "context": childCommentController.text,
          "parentCommentId": index
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

/**게시글 타입 별 */
Future<PostList> listTypePost(ctg, postNum) async {
  var url = 'http://moida-skhu.duckdns.org/post/type/${ctg}/${postNum}';

  String? token = await storage.read(key: 'Token');

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  if (response.statusCode == 200) {
    print(token);
    print('타입별 게시글 목록${response.body}');
  } else {
    print(response.body);
  }

  final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

  return new PostList.fromJson(jsonResponse);
}

/**게시글 삭제 */
Future<void> deletePost(id) async {
  var url = 'http://moida-skhu.duckdns.org/post/${id}';

  String? token = await storage.read(key: 'Token');

  var response = await http.delete(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  print(response.body);
}

/**게시글 수정 */
Future<ModiPostModel> modifyPost(id) async {
  var url = 'http://moida-skhu.duckdns.org/post/edit/${id}';

  String? token = await storage.read(key: 'Token');
  ModiPostModel modiPostModel;

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  print('modify : ${response.body}');
  var data = json.decode(utf8.decode(response.bodyBytes));
  modiPostModel = ModiPostModel(
      author: data['author'],
      title: data['title'],
      type: data['type'],
      context: data['context'],
      modifiedDate: data['modifiedDate']);
  return modiPostModel;
}

class ModiPostModel {
  final String title; //게시글 제목
  final String type; //게시글 태그
  final String context; //게시글 내용
  final String author;
  final String modifiedDate; //게시글 작성자
  ModiPostModel(
      {required this.title,
      required this.type,
      required this.context,
      required this.author,
      required this.modifiedDate});
}

class modiPostController {
  static TextEditingController modyTitleController =
      TextEditingController(); //modyTitleController
  static TextEditingController modyTypeController =
      TextEditingController(); //modyTypeController
  static TextEditingController modyContextController =
      TextEditingController(); //modyContextController
  static Future modiPostPath(id, author) async {
    var url = 'http://moida-skhu.duckdns.org/post/edit/${id}';

    String? token = await storage.read(key: 'Token');

    var response = await http.patch(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({
          "author": author,
          "title": modyTitleController.text,
          "type": modyTypeController.text,
          "context": modyContextController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

/**댓글 수정 */
class modifyCommentsClass {
  static TextEditingController modyCommentsController =
      TextEditingController(); //modyCommentsController
  static Future modifyComments(postId, commentId) async {
    var url =
        'http://moida-skhu.duckdns.org/post/${postId}/comments/${commentId}';

    String? token = await storage.read(key: 'Token');
    ModiPostModel modiPostModel;

    var response = await http.patch(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${token}',
          "Content-Type": "application/json",
          'Charset': 'utf-8',
        },
        body: jsonEncode({"context": modyCommentsController.text}));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

/**댓글 삭제 */
Future<void> deleteComments(postId, commentId) async {
  var url =
      'http://moida-skhu.duckdns.org/post/${postId}/comments/${commentId}';

  String? token = await storage.read(key: 'Token');

  var response = await http.delete(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  print(response.body);
}
