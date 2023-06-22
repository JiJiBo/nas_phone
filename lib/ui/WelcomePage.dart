import 'package:flutter/material.dart';
import 'package:nas_phone/ExtUtils.dart';

import '../mobox/route.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() {
    return _WelcomePage();
  }
}

class _WelcomePage extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    initTheFirst();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "电话本",
                style: TextStyle(fontSize: 30, color: Colors.blueAccent),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initTheFirst() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      routeStore.home_ui_route.push(context);
    });
  }
}
