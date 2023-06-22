import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPage createState() {
    return _EmptyPage();
  }
}

class _EmptyPage extends State<EmptyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: SafeArea(
            top: true,
            child: Offstage(),
          ),
        ),
        body: Center(
          child: Text("empty ui"),
        ));
  }
}
