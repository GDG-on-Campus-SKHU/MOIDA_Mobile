import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moida_mobile/Controller/authController.dart';
import 'package:moida_mobile/Screens/Post/PostList.dart';
import 'package:moida_mobile/Screens/SignIn.dart';

import 'package:moida_mobile/Screens/loginTest.dart';
import 'package:moida_mobile/Styles/ColorStyles.dart';
import 'package:moida_mobile/Styles/Styles.dart';
import 'package:moida_mobile/main.dart';

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
    loginController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/moidaLogo.png'))),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: ColorStyle.mainColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: LoginController.usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Id',
                      hintStyle: TextStyle(
                        color: ColorStyle.mainColor,
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
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: ColorStyle.mainColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    controller: LoginController.passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'PassWord',
                      hintStyle: TextStyle(
                        color: ColorStyle.mainColor,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          // border: Border.all(
                          //   width: 1,
                          //   color: ColorStyle.mainColor,
                          // ),
                          color: ColorStyle.mainColor),
                      child: Text(
                        "로그인",
                        style: Styles.loginBoxText,
                      ),
                    ),
                    onTap: () async {
                      // loginController.loginUser();
                      if (await LoginController.loginUser()) {
                        fToast.showToast(
                            child: Text('로그인에 실패했습니다. 회원정보를 확인해주세요.'));
                        print('login error');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PostListPage())));
                      }
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
                          // border: Border.all(
                          //   width: 1,
                          //   color: ColorStyle.mainColor,
                          // ),
                          color: ColorStyle.mainColor),
                      child: Text(
                        "회원가입",
                        style: Styles.loginBoxText,
                      ),
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
