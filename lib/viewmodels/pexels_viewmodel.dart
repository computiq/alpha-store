import 'dart:convert';

import 'package:alpha_store/models/category.dart';
import 'package:alpha_store/models/error.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/photo.dart';
import 'package:alpha_store/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class PexelsViewModel extends ChangeNotifier {
  late Tuple2<ErrorResponse?, List<Photo>?> photosResponse;
  LoadingState loadingState = LoadingState.idle;

  int page = 0;

  PexelsViewModel() {
    photosResponse = const Tuple2(null, null);
  }

  void rest() {
    photosResponse = const Tuple2(null, null);
    loadingState = LoadingState.idle;
  }

  void fetchImages() async {
    loadingState = LoadingState.loading;
    notifyListeners();

    var response;
    try {
      var url = Uri.parse('https://api.pexels.com/v1/curated?page=$page&per_page=10');
      debugPrint('url: ${url}');
      response = await http.get(
        url,
        headers: {'Authorization': '563492ad6f91700001000001797bc5d66551440499645bece51aee9e'}
      );

      var jsonModels = jsonDecode(response.body)['photos'];
      List<Photo> models = jsonModels.map<Photo>((_modelJson) => Photo.fromJson(_modelJson)).toList();

      page = page + 1;

      photosResponse = Tuple2(null, models);
    } catch (e) {
      if (response?.statusCode == 200) {
        photosResponse = Tuple2(ErrorResponse('توجد مشكلة في عرض المعلومات', response?.statusCode), null);
      } else {
        photosResponse = Tuple2(ErrorResponse('لا يمكن الإتصال. يرجى المحاولة فيما بعد...', -1), null);
      }

      debugPrint('e: $e');
    }

    loadingState = LoadingState.finished;
    notifyListeners();
  }
}
