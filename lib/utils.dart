import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future openPage(BuildContext context, Widget page) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return page;
  }));
}
