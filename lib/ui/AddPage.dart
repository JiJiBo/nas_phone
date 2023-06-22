import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nas_phone/db/LocalAddressDb.dart';
import 'package:nas_phone/mobox/contact.dart';

import '../np.dart';

class AddPage extends StatefulObserverWidget {
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

  TextEditingController _textController = TextEditingController();
  List<Contact> contacts = [];
  List<Map> had = [];
  String filterText = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("选择联系人"),
          actions: [
            TextButton(
                onPressed: () async {
                  await FlutterContacts.openExternalInsert();
                  initData();
                },
                child: Text("添加"))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      autofocus: false,
                      controller: _textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "搜索",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        filterText = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return _getItemWithIndex(contacts[index]);
                    }))
          ],
        ));
  }

  Widget _getItemWithIndex(Contact contact) {
    return Visibility(
        visible: contact.phones.length > 0 &&
            contact.phones.first.number != "" &&
            (contact.displayName.contains(filterText) ||
                (contact.phones[0].number
                    .replaceAll(" ", "")
                    .contains(filterText))),
        child: Card(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              extentRatio: 0.6,
              motion: const ScrollMotion(),
              children: [
                Visibility(
                  visible: !contactStore.isInLocal(contact.id),
                  child: SlidableAction(
                    flex: 2,
                    onPressed: (v) async {
                      await contactStore.addLocal(contact.displayName,
                          contact.phones[0].number, contact.id);
                      setState(() {});
                    },
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.add,
                    label: "添加",
                  ),
                ),
                Visibility(
                  visible: contactStore.isInLocal(contact.id),
                  child: SlidableAction(
                    flex: 2,
                    onPressed: (v) async {
                      await contactStore.deleteLocal(contact.id);
                      setState(() {});
                    },
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: "删除",
                  ),
                ),
                SlidableAction(
                  flex: 2,
                  onPressed: (v) async {
                    await FlutterContacts.openExternalEdit(contact.id);
                    initData();
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: "编辑",
                ),
              ],
            ),
            child: TextButton(
                onPressed: () async {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 70,
                          padding: EdgeInsets.only(left: 13),
                          child: Row(
                            children: [
                              contact.photo == null
                                  ? Container(
                                      width: 45,
                                      height: 45,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Colors.grey,
                                      ),
                                      child: Text(
                                          contact.displayName.length > 0
                                              ? contact.displayName[0]
                                                  .toUpperCase()
                                              : "",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)))
                                  : Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          image: DecorationImage(
                                              image:
                                                  MemoryImage(contact.photo!),
                                              fit: BoxFit.cover)),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //photo

                                  Text(contact.displayName ?? ""),
                                  Text(
                                    contact.phones.length > 0
                                        ? contact.phones[0]?.number ?? ""
                                        : "",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, "/contact_detail_page",
                              arguments: contact);
                        },
                        icon: Icon(
                          Icons.chevron_right,
                          color: contactStore.isInLocal(contact.id)
                              ? Colors.green
                              : Colors.red,
                        ))
                  ],
                )),
          ),
        ));
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
}
