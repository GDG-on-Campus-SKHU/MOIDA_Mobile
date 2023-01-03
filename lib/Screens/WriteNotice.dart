import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WriteNotice extends StatefulWidget {
  const WriteNotice({super.key});

  @override
  State<WriteNotice> createState() => _WriteNoticeState();
}

class _WriteNoticeState extends State<WriteNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [Text('data')],
      )),
    );
  }
}
