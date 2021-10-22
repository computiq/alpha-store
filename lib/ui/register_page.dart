import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var emailTextController = TextEditingController();
  var mobileController = TextEditingController();

  Widget registrationStatus() {
    return Consumer<ProductsViewModel>(builder: (context, viewModel, child) {
      Widget view = Text('Idle!');

      if (viewModel.registrationLoadingState == LoadingState.loading) {
        view = Center(child: const CircularProgressIndicator());
      } else if (viewModel.registrationLoadingState == LoadingState.finished) {
        if (viewModel.registrationResponse.item1 == null) {
          view = Text('Success');
        } else {
          view = Text('Error!');
        }
      }
      return view;
    });
  }

  @override
  Widget build(BuildContext context) {
    var headerImage = SvgPicture.asset('images/undraw_Notify_re_65on.svg', height: 200, semanticsLabel: 'Acme Logo');

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ListView(
        children: [
          registrationStatus(),
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
                child: TextFormField(
                  textAlign: TextAlign.start,
                  controller: emailTextController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
            ),
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
                  decoration: InputDecoration(hintText: 'Username'),
                ),
              ),
            ),
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
                  decoration: InputDecoration(hintText: 'Password'),
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
                  controller: mobileController,
                  decoration: InputDecoration(hintText: 'Mobile Number'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  if (emailTextController.text.isEmpty) {
                    final snackBar = SnackBar(content: Text('Please enter your email'));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Provider.of<ProductsViewModel>(context, listen: false).register(
                        email: 'a@a.com', username: 'bluemix', password: '12345', mobileNumber: '123456778');
                  }
                },
                child: Text('Register')),
          ),
        ],
      ),
    );
  }
}
