import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void showCallDialog(BuildContext context, String number) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 400,
            height: 400,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      bool? res =
                          await FlutterPhoneDirectCaller.callNumber(number);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                      child: Text("打",
                          style: TextStyle(color: Colors.white, fontSize: 50)),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      color: Colors.red.shade500,
                      child: Text("不打",
                          style: TextStyle(color: Colors.white, fontSize: 50,fontStyle: FontStyle.normal)),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
