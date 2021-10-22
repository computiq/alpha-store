import 'package:alpha_store/models/product.dart';
import 'package:alpha_store/utils/app_utils.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class CartPage extends StatefulWidget {
  const CartPage();

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin<CartPage> {
  late ProductsViewModel _productsViewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    debugPrint('_CartPageState.initState...');
  }

  Widget buildItemView(Product model) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: model.image,
              height: 100,
              width: 100,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) {
                debugPrint('error: $error');
                return const Icon(Icons.error);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Text(
              '1',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView(List<Product> models) {
    return ListView.builder(
      itemBuilder: (_context, index) => buildItemView(models[index]),
      itemCount: models.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _productsViewModel = Provider.of<ProductsViewModel>(context);

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xfff9f7f0),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(child: buildListView(_productsViewModel.cartItems)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: screenWidth * 0.9),
                child: ElevatedButton(
                    onPressed: () {
                      openPage(context, LoginPage());
                    },
                    child: const Text('Place Order')),
              ),
            )
          ],
        ));
  }
}
