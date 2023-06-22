import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart';

extension RouteExt on String {
  void push(BuildContext context) {
    Navigator.pushNamed(context, this);
  }
}

extension StrExt on String {
  File get toFile => File(this);

  Uint8List get toUint8List => this.toFile.readAsBytesSync();
}

extension Uint8ListExt on Uint8List {
  File get toFile => File.fromRawPath(this);

//  获取图片的宽高
  Future<Size> get toSize async {
    final image = decodeImage(this)!;
    return Size(image.width.toDouble(), image.height.toDouble());
  }
}
