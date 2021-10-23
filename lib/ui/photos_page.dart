import 'package:alpha_store/models/category.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/photo.dart';
import 'package:alpha_store/viewmodels/categories_viewmodel.dart';
import 'package:alpha_store/viewmodels/pexels_viewmodel.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage();

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late PexelsViewModel _pexelsViewModel;

  @override
  void initState() {
    super.initState();

    debugPrint('_PhotosPageState.initState...');

    Future.microtask(() {
      if (_pexelsViewModel.photosResponse.item2 == null) {
        _pexelsViewModel.fetchImages();
      }
    });
  }

  Widget buildItemView(Photo photo) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: photo.src.medium,
          height: 200,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) {
            debugPrint('error: $error');
            return Icon(Icons.error);
          },
        ),
      ),
    );
  }

  Widget buildListView(List<Photo> images) {
    return ListView.builder(
      itemBuilder: (_context, index) => buildItemView(images[index]),
      itemCount: images.length,
    );
  }

  @override
  Widget build(BuildContext context) {

    _pexelsViewModel = Provider.of<PexelsViewModel>(context);

    Widget view = const Text('Idle!');

    if (_pexelsViewModel.loadingState == LoadingState.loading) {
      view = const CircularProgressIndicator();
    } else if (_pexelsViewModel.loadingState == LoadingState.finished) {
      if (_pexelsViewModel.photosResponse.item1 == null) {
        view = buildListView(_pexelsViewModel.photosResponse.item2 ?? []);
      } else {
        view = Text('Error!');
      }
    }

    return Scaffold(body: Center(child: view));
  }
}
