import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/product.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProductsViewModel _productsViewModel;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _productsViewModel.fetchProducts());
  }

  Widget buildItemView(Product product) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: product.image,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${product.price}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridListView(List<Product> products) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: 0.6, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemCount: products.length,
        itemBuilder: (BuildContext ctx, index) {
          return buildItemView(products[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    _productsViewModel = Provider.of<ProductsViewModel>(context);

    Widget view = Text('Idle!');

    if (_productsViewModel.loadingState == LoadingState.loading) {
      view = const CircularProgressIndicator();
    } else if (_productsViewModel.loadingState == LoadingState.finished) {
      if (_productsViewModel.productsResponse.item1 == null) {
        view = buildGridListView(_productsViewModel.productsResponse.item2 ?? []);
      } else {
        view = Text('Error!');
      }
    }

    return Scaffold(body: Center(child: view));
  }
}
