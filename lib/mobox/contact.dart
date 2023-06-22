import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mobx/mobx.dart';

import '../db/LocalAddressDb.dart';

// This is our generated file (we'll see this soon!)
part 'contact.g.dart';

// We expose this to be used throughout our project
class contact = _contact with _$contact;

final contactStore = contact();

// Our store class
abstract class _contact with Store {
  @observable
  List<Map> had = [];

  @action
  Future<void> getAllLocalData() async {
    had = await getLocalAllData();
  }

  bool isInLocal(String id) {
    bool isHad = false;
    had.forEach((element) {
      if (element["ext"] == id) {
        isHad = true;
        return;
      }
    });
    return isHad;
  }

  @action
  Future<void> deleteLocal(String ext) async {
    await delLocalDataByExt(ext);
    await getAllLocalData();
  }

  @action
  Future<void> addLocal(String name, String phone, String id) async {
    await addLocalData(name, phone, ext: id);
    await getAllLocalData();
  }

  Future<void> call(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
