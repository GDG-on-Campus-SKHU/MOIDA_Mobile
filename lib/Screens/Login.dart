import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Screens/SignIn.dart';
import 'package:moida_mobile/Screens/loginTest.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = LoginController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MOIDA Login Page"),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: loginController.usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'UserName',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: loginController.passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'PassWord',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber),
                      child: Text("로그인"),
                    ),
                    onTap: () {
                      // if (loginController.loginUser()) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: ((context) => LoginTest())));
                      // } else {
                      //   fToast.showToast(
                      //       child: Text('로그인에 실패했습니다. 회원정보를 확인해주세요'));
                      // }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber),
                      child: Text("회원가입"),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Signin())));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
