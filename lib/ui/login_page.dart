import 'package:alpha_store/ui/register_page.dart';
import 'package:alpha_store/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var mobileTextController = TextEditingController();
  var passwordTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    var headerImage = Image.asset(
        'images/undraw_Login_re_4vu2.png',
        height: 200,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: headerImage,
          ),
          Container(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), ) ,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: mobileTextController,
                  decoration: InputDecoration(
                      hintText: 'Mobile Number'
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10), ) ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: passwordTextController,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(onPressed: () {
              if (mobileTextController.text.isEmpty) {
                debugPrint('mobileTextController.text is empty...');
              }
              debugPrint('mobileTextController.text: ${mobileTextController.text}');
              debugPrint('passwordTextController.text: ${passwordTextController.text}');
            }, child: Text('Login')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Text('If you\'re new to our platform, you can'),
                TextButton(
                  onPressed: () {
                    openPage(context, RegisterPage());
                  },
                  child: Text('Register'),
                ),
                Text('now'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
