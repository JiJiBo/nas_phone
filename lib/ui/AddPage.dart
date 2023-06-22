import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPage createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("empty ui"),
    ));
  }

  void initData() {
    FlutterContacts.getContacts().then((value) {
      print(value);
    });
  }
}
