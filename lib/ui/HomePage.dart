import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:nas_phone/ExtUtils.dart';
import 'package:nas_phone/mobox/route.dart';
import 'package:nas_phone/np.dart';
import 'package:permission_handler/permission_handler.dart';

import '../mobox/contact.dart';

class HomePage extends StatefulObserverWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with LifecycleAware, LifecycleMixin {
  @override
  void initState() {
    super.initState();
    initForPermission();
  }

  List<Contact> contacts = [];

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
            padding: EdgeInsets.only(bottom: 40),
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _getItemWithIndex(contacts[index]);
              },
            )));
  }

  void initData() {
    contactStore.getAllLocalData().then((v) {
      FlutterContacts.getContacts(withProperties: true, withPhoto: true)
          .then((value) {
        contacts = value;
        setState(() {});
      });
    });
  }

  Widget _getItemWithIndex(Contact contact) {
    return Visibility(
      visible: contactStore.isInLocal(contact.id),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            contact.photo == null
                ? Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    child: Text(
                        contact.displayName.length > 0
                            ? contact.displayName[0].toUpperCase()
                            : "",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))
                : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: MemoryImage(contact.photo!),
                            fit: BoxFit.cover))),
            Expanded(
                child: ListTile(
              dense: false,
              title: Container(
                child: Text(
                  contact.displayName,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              subtitle: Text(
                contact.phones.first.number,
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                contactStore.call(contact.phones.first.number);
              },
            ))
          ],
        ),
      ),
    );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      setState(() {});
    }
  }

  Future<void> initForPermission() async {
    if (await Permission.contacts.request().isGranted) {
      initData();
    } else {
      "请授予通讯录权限".bbToast();
    }
  }
}
