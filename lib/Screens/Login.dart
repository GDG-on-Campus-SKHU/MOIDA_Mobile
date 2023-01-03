import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Screens/SignIn.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
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
                    onTap: () {},
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
