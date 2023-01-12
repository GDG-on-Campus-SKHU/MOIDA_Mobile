import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class SigninController {
  //회원가입 클래스
  TextEditingController usernameController =
      TextEditingController(); //usernameController
  TextEditingController passwordController =
      TextEditingController(); //Password Controller
  TextEditingController repeatedPasswordController =
      TextEditingController(); //repeatedPasswordController
  TextEditingController nicknameController =
      TextEditingController(); //nicknameController
  Future signinUser() async {
    const url = 'http://moida-skhu.duckdns.org/join';

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
          "repeatedPassword": repeatedPasswordController.text,
          "nickname": nicknameController.text
        }));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}

class LoginController {
  //로그인 클래스 & 토큰 관리

  static TextEditingController usernameController =
      TextEditingController(); //usernameController
  static TextEditingController passwordController =
      TextEditingController(); //Password Controller

  static Future<bool> loginUser() async {
    const url = 'http://moida-skhu.duckdns.org/login';
    // http.Response response;
    User userData;
    var data;

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", 'Charset': 'utf-8'},
        body: jsonEncode({
          "username": usernameController.text,
          "password": passwordController.text,
        }));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print("${response.statusCode}");
      userData = User(
        grantType: data["grantType"],
        accessToken: data["accessToken"],
      );
      String token = userData.accessToken.toString();
      String userID = usernameController.text;
      await storage.write(key: 'userID', value: userID);
      await storage.write(key: 'Token', value: token);
      print(token);
      print(response.body);
      return response.body.isEmpty;
    } else {
      print(response.statusCode);
      return response.body.isEmpty;
    }
  }
}

class UserTokenList {
  //토큰 받아오는 클래스
  List<User>? userToken;

  UserTokenList({this.userToken});

  UserTokenList.fromJson(Map<String, dynamic> json) {
    if (json['week'] != null) {
      userToken = <User>[];
      json['week'].forEach((v) {
        userToken!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userToken != null) {
      data['week'] = this.userToken!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? grantType;
  String? accessToken;

  User({
    this.grantType,
    this.accessToken,
  });
  User.fromJson(Map<String, dynamic> json) {
    grantType = json['grantType'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grantType'] = this.grantType;
    data['accessToken'] = this.accessToken;
    return data;
  }
}

Future<getUserStatus> getUserId() async {
  const url = 'http://moida-skhu.duckdns.org/user';
  // http.Response response;

  String? token = await storage.read(key: 'Token');
  getUserStatus getStatus;

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );

  if (response.statusCode == 200) {
    print('로그인 정보 ${response.body}');
    var data = json.decode(response.body);
    getStatus =
        getUserStatus(username: data['username'], nickname: data['nickname']);
    print('${response.body}');
    return getStatus;
  } else {
    print('로그인 정보 ${response.body}');

    getStatus = getUserStatus(username: 'null', nickname: 'null');
    print('${response.body}');
    return getStatus;
  }
}

class getUserStatus {
  final String username; //user id
  final String nickname; //user nicname

  getUserStatus({
    required this.username,
    required this.nickname,
  });
}

Future<MyPageData> userDataPost() async {
  const url = 'http://moida-skhu.duckdns.org/user';

  String? token = await storage.read(key: 'Token');

  var response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer ${token}'},
  );
  if (response.statusCode == 200) {
    print(token);
    print('마이페이지 데이터${response.body}');
  } else {
    print(response.body);
  }

  final jsonResponse = json.decode(utf8.decode(response.bodyBytes));

  return new MyPageData.fromJson(jsonResponse);
}

/**마이페이지 데이터 모델 */
class MyPageData {
  String? username;
  String? nickname;
  Posts? posts;

  MyPageData({this.username, this.nickname, this.posts});

  MyPageData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    nickname = json['nickname'];
    posts = json['posts'] != null ? new Posts.fromJson(json['posts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    if (this.posts != null) {
      data['posts'] = this.posts!.toJson();
    }
    return data;
  }
}

class Posts {
  List<MyContent>? myContent;

  Posts({this.myContent});

  Posts.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      myContent = <MyContent>[];
      json['content'].forEach((v) {
        myContent!.add(new MyContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myContent != null) {
      data['content'] = this.myContent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyContent {
  int? id;
  String? author;
  String? title;
  String? type;
  String? context;
  Null? comments;
  String? createdDate;
  String? modifiedDate;

  MyContent(
      {this.id,
      this.author,
      this.title,
      this.type,
      this.context,
      this.comments,
      this.createdDate,
      this.modifiedDate});

  MyContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    type = json['type'];
    context = json['context'];
    comments = json['comments'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['type'] = this.type;
    data['context'] = this.context;
    data['comments'] = this.comments;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}
