import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/main.dart';
import '../Controller/authController.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Styles/ColorStyles.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String password = '';
  String repeatedPassword = '';
  SigninController signinController = SigninController();
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
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: signinController.usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'UserName',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: signinController.passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: signinController.repeatedPasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'repeatedPassword',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: signinController.nicknameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'NickName',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorStyle.mainColor),
                  child: Text("회원가입"),
                ),
                onTap: () {
                  if (password != repeatedPassword) {
                    fToast.showToast(child: Text('비밀번호를 확인주세요'));
                  } else {
                    fToast.showToast(child: Text('회원가입에 성공했습니다.'));
                    signinController.signinUser();
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => MyApp())));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
