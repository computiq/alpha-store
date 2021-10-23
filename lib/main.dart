import 'package:alpha_store/ui/categories_page.dart';
import 'package:alpha_store/ui/home_page.dart';
import 'package:alpha_store/ui/more_page.dart';
import 'package:alpha_store/ui/photos_page.dart';
import 'package:alpha_store/viewmodels/app_viewmodel.dart';
import 'package:alpha_store/viewmodels/categories_viewmodel.dart';
import 'package:alpha_store/viewmodels/pexels_viewmodel.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'i18n/translations.dart';
import 'i18n/translations_delegate.dart';

const Locale arLocale = Locale('ar');
const Locale enLocale = Locale('en');

Locale? prevLocale;


void main() {


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppViewModel>(create: (_) => AppViewModel()),
      ChangeNotifierProvider<ProductsViewModel>(create: (_) => ProductsViewModel()),
      ChangeNotifierProvider<CategoriesViewModel>(
        create: (_) => CategoriesViewModel(),
        lazy: true,
      ),
      ChangeNotifierProvider<PexelsViewModel>(
        create: (_) => PexelsViewModel(),
        lazy: true,
      ),
    ],
    child: Consumer<AppViewModel>(builder: (context, viewModel, child) {

      return MyApp(viewModel.appLocale);
    }),
  ));
}

class MyApp extends StatelessWidget {
  MyApp(this.currentLocate, {Key? key}) : super(key: key);

  List<Locale> get supportedLocales => [
        arLocale,
        enLocale,
      ];

  final Locale currentLocate;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: const [
        AlphaStoreLocalizationDelegate(),
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      locale: currentLocate,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesPage(),
    PhotosPage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Translations.of(context).more,
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
