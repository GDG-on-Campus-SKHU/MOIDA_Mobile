import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moida_mobile/Screens/WriteNotice.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('noticeList Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_note_outlined),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => WriteNotice())));
        },
      ),
    );
  }
}
