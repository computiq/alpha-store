import 'dart:convert';

import 'package:alpha_store/models/category.dart';
import 'package:alpha_store/models/error.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/product.dart';
import 'package:alpha_store/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class ProductsViewModel extends ChangeNotifier {
  late Tuple2<ErrorResponse?, List<Product>?> productsResponse;
  LoadingState loadingState = LoadingState.idle;

  late Tuple2<ErrorResponse?, List<Category>?> categoriesResponse;
  LoadingState categoriesLoadingState = LoadingState.idle;

  late Tuple2<ErrorResponse?, User?> registrationResponse;
  LoadingState registrationLoadingState = LoadingState.idle;

  List<Product> cartItems = [];

  ProductsViewModel() {
    productsResponse = const Tuple2(null, null);
    categoriesResponse = const Tuple2(null, null);
    registrationResponse = const Tuple2(null, null);
  }

  void addToCart(Product product) {
    bool exists = cartItems.indexWhere((element) => element.id == product.id) >= 0;

    if (!exists) {
      cartItems.add(product);
      notifyListeners();
    }
  }

  bool isInCart(Product product) {
    return cartItems.indexWhere((element) => element.id == product.id) >= 0;
  }

  void fetchCategories() async {
    categoriesLoadingState = LoadingState.loading;
    notifyListeners();

    var response;
    try {
      var url = Uri.parse('https://api.jsonbin.io/b/617094d44a82881d6c632722');
      debugPrint('url: ${url}');
      response = await http.get(
        url,
      );
      debugPrint('response: ${response}');
      debugPrint('response.statusCode: ${response.statusCode}');
      var categoriesJson = jsonDecode(response.body);
      var categories = categoriesJson.map<Category>((_categoryJson) => Category.fromJson(_categoryJson)).toList();

      categoriesResponse = Tuple2(null, categories);
    } catch (e) {
      if (response?.statusCode == 200) {
        categoriesResponse = Tuple2(ErrorResponse('توجد مشكلة في عرض المعلومات', response?.statusCode), null);
      } else {
        categoriesResponse = Tuple2(ErrorResponse('لا يمكن الإتصال. يرجى المحاولة فيما بعد...', -1), null);
      }

      debugPrint('catch categories error: $e');
    }

    categoriesLoadingState = LoadingState.finished;
    notifyListeners();
  }

  void register({required String email, required String username, required password, required mobileNumber}) async {
    registrationLoadingState = LoadingState.loading;
    notifyListeners();

    var response;
    try {
      var url = Uri.parse('https://fakestoreapi.com/users');
      debugPrint('url: ${url}');
      
      var body = {
        'email': email,
        'username': username,
        'password': password,
        'name': {
          'firstname': 'John',
          'lastname': 'Doe'
        },
        'address': {
          'city': 'kilcoole',
          'street': '7835 new road',
          'number': 3,
          'zipcode': '12926-3874',
          'geolocation': {
            'lat': '-37.3159',
            'long': '81.1496'
          }
        },
        'phone': mobileNumber
      };
      
      response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint('response: ${response}');
      debugPrint('response.statusCode: ${response.statusCode}');
      var userJson = jsonDecode(response.body);
      var _user = User.fromJson(userJson);

      registrationResponse = Tuple2(null, _user);
    } catch (e) {
      if (response?.statusCode == 200) {
        registrationResponse = Tuple2(ErrorResponse('توجد مشكلة في عرض المعلومات', response?.statusCode), null);
      } else {
        registrationResponse = Tuple2(ErrorResponse('لا يمكن الإتصال. يرجى المحاولة فيما بعد...', -1), null);
      }

      debugPrint('registration error: $e');
    }

    registrationLoadingState = LoadingState.finished;
    notifyListeners();
  }

  void fetchProducts() async {
    loadingState = LoadingState.loading;
    notifyListeners();

    var response;
    try {
      var url = Uri.parse('https://api.jsonbin.io/b/6170949baa02be1d445c66cb');
      debugPrint('url: ${url}');
      response = await http.get(
        url,
      );
      debugPrint('response: ${response}');
      debugPrint('response.statusCode: ${response.statusCode}');
      var jsonUsers = jsonDecode(response.body);
      var users = jsonUsers.map<Product>((_userJson) => Product.fromJson(_userJson)).toList();

      productsResponse = Tuple2(null, users);
    } catch (e) {
      if (response?.statusCode == 200) {
        productsResponse = Tuple2(ErrorResponse('توجد مشكلة في عرض المعلومات', response?.statusCode), null);
      } else {
        productsResponse = Tuple2(ErrorResponse('لا يمكن الإتصال. يرجى المحاولة فيما بعد...', -1), null);
      }

      debugPrint('e: $e');
    }

    loadingState = LoadingState.finished;
    notifyListeners();
  }
}
