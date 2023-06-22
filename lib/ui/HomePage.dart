import 'package:flutter/material.dart';
import 'package:nas_phone/ExtUtils.dart';
import 'package:nas_phone/mobox/route.dart';
import 'package:nas_phone/np.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
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
        appBar: AppBar(
          title: Text("电话本"),
          actions: [
            GestureDetector(
                onLongPress: () async {
                  if (await Permission.contacts.request().isGranted) {
                    routeStore.add_ui_route.push(context);
                  } else {
                    "请授予通讯录权限".bbToast();
                  }
                },
                child: Icon(Icons.add))
          ],
        ),
        body: Container(
          child: ListView(),
        ));
  }
}
