import 'package:flutter/material.dart';

class Modelclass with ChangeNotifier {
  uploadimageurl(String _url) {
    Map<String, dynamic> addurl = {
      'url': _url,
    };
    print(_url);
    notifyListeners();
  }
}
