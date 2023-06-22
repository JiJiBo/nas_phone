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
    initData();
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
          padding: EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
          child: ListTile(
            leading: contact.photo == null
                ? Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
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
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: DecorationImage(
                            image: MemoryImage(contact.photo!),
                            fit: BoxFit.cover))),
            title: Text(
              contact.displayName,
              style: TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              contact.phones.first.number,
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              contactStore.call(contact.phones.first.number);
            },
          ),
        ));
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      setState(() {});
    }
  }
}
