import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future openPage(BuildContext context, Widget page) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (_context) => page));
}
