import 'dart:convert';

import 'package:alpha_store/models/category.dart';
import 'package:alpha_store/models/error.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../main.dart';

class AppViewModel extends ChangeNotifier {

  Locale appLocale = arLocale;
  AppViewModel() {

  }


  void switchLanguage() {
    if (appLocale == arLocale) {
      appLocale = enLocale;
    } else {
      appLocale = arLocale;
    }

    notifyListeners();
  }

}
