// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$contact on _contact, Store {
  late final _$hadAtom = Atom(name: '_contact.had', context: context);

  @override
  List<Map<dynamic, dynamic>> get had {
    _$hadAtom.reportRead();
    return super.had;
  }

  @override
  set had(List<Map<dynamic, dynamic>> value) {
    _$hadAtom.reportWrite(value, super.had, () {
      super.had = value;
    });
  }

  late final _$getAllLocalDataAsyncAction =
      AsyncAction('_contact.getAllLocalData', context: context);

  @override
  Future<void> getAllLocalData() {
    return _$getAllLocalDataAsyncAction.run(() => super.getAllLocalData());
  }

  late final _$deleteLocalAsyncAction =
      AsyncAction('_contact.deleteLocal', context: context);

  @override
  Future<void> deleteLocal(String ext) {
    return _$deleteLocalAsyncAction.run(() => super.deleteLocal(ext));
  }

  late final _$addLocalAsyncAction =
      AsyncAction('_contact.addLocal', context: context);

  @override
  Future<void> addLocal(String name, String phone, String id) {
    return _$addLocalAsyncAction.run(() => super.addLocal(name, phone, id));
  }

  @override
  String toString() {
    return '''
had: ${had}
    ''';
  }
}
