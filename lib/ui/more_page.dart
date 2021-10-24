import 'package:alpha_store/i18n/translations.dart';
import 'package:alpha_store/viewmodels/app_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text(Translations.of(context).switchLanguage),
        onPressed: () {
          Provider.of<AppViewModel>(context, listen: false).switchLanguage();
        },
      ),
    );
  }

}