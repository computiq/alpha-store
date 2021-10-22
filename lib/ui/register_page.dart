import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  Widget registerStatus() {
    return Consumer<ProductsViewModel>(builder: (context, viewModel, child) {
      Widget view = Container();

      if (viewModel.registerLoadingState == LoadingState.loading) {
        view = Center(child: const CircularProgressIndicator());
      } else if (viewModel.registerLoadingState == LoadingState.finished) {
        if (viewModel.registerResponse.item1 == null) {
          view = Text('Registered Successfully with id ${viewModel.registerResponse.item2?.id}', textAlign: TextAlign.center,);
        } else {
          view = Text('Error!');
        }
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: view,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var headerImage = Image.asset(
      'images/undraw_Login_re_4vu2.png',
      height: 200,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Registration'),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: headerImage,
          ),
          Container(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: emailTextController,
                  decoration: InputDecoration(hintText: 'Mobile Number'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: passwordTextController,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: passwordTextController,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: passwordTextController,
                  decoration: const InputDecoration(hintText: 'Address'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  if (emailTextController.text.isEmpty) {
                    debugPrint('emailTextController.text is empty...');
                  }
                  debugPrint('emailTextController.text: ${emailTextController.text}');
                  debugPrint('passwordTextController.text: ${passwordTextController.text}');

                  Provider.of<ProductsViewModel>(context, listen: false).register(
                      email: 'a@a.com',
                      username: 'username',
                      password: '123456',
                      fullName: 'Ahmed Ali',
                      mobileNumber: '07700000000',
                      address: 'Baghdad');
                },
                child: Text('Register')),
          ),

          registerStatus()
        ],
      ),
    );
  }
}
