import 'package:alpha_store/models/category.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage();

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with AutomaticKeepAliveClientMixin<CategoriesPage> {
  late ProductsViewModel _productsViewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    debugPrint('_CategoriesPageState.initState...');

    Future.microtask(() => _productsViewModel.fetchCategories());
  }

  Widget buildItemView(Category category) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(child: Container()),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  Widget buildGridListView(List<Category> categories) {
    return ListView.builder(
      itemBuilder: (_context, index) => buildItemView(categories[index]),
      itemCount: categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _productsViewModel = Provider.of<ProductsViewModel>(context);

    Widget view = const Text('Idle!');

    if (_productsViewModel.categoriesLoadingState == LoadingState.loading) {
      view = const CircularProgressIndicator();
    } else if (_productsViewModel.categoriesLoadingState == LoadingState.finished) {
      if (_productsViewModel.categoriesResponse.item1 == null) {
        view = buildGridListView(_productsViewModel.categoriesResponse.item2 ?? []);
      } else {
        view = Text('Error!');
      }
    }

    return Scaffold(body: Center(child: view));
  }
}
