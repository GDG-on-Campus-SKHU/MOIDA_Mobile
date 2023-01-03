import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Controller/authController.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  // String username = '';
  // String password = '';
  // String repeatedPassword = '';
  // String nickname = '';
  // TextEditingController usernameController =
  //     TextEditingController(); //usernameController
  // TextEditingController passwordController =
  //     TextEditingController(); //Password Controller
  // TextEditingController repeatedPasswordController =
  //     TextEditingController(); //repeatedPasswordController
  // TextEditingController nicknameController =
  //     TextEditingController(); //nicknameController
  SigninController signinController = SigninController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MOIDA SignIn Page"),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
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
                  // onChanged: (value) {
                  //   setState(() {
                  //     username = value;
                  //   });
                  // },
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
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
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
                  // onChanged: (value) {
                  //   setState(() {
                  //     password = value;
                  //   });
                  // },
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
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
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
                  // onChanged: (value) {
                  //   setState(() {
                  //     repeatedPassword = value;
                  //   });
                  // },
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
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
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
                  // onChanged: (value) {
                  //   setState(() {
                  //     nickname = value;
                  //   });
                  // },
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
                    color: Colors.amber),
                child: Text("회원가입"),
              ),
              onTap: () {
                signinController.signinUser();
              },
            )
          ],
        ),
      ),
    );
  }
}
