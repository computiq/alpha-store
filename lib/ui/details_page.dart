import 'package:alpha_store/models/product.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.product);

  final Product product;

  Widget buildItemView() {
    return ListView(
      children: [
        CachedNetworkImage(
          imageUrl: product.image,
          height: 400,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) {
            debugPrint('error: $error');
            return Icon(Icons.error);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '\$${product.price}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${product.description}',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            product.title,
            maxLines: 1,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_outline),
              onPressed: () {},
            )
          ],
        ),
        body: Center(
            child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            buildItemView(),
            Consumer<ProductsViewModel>(builder: (context, viewModel, child) {
              bool isInCart = viewModel.isInCart(product);

              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 600),
                firstChild: Container(
                  height: 50,
                  width: screenWidth,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Text(
                    'Added to Cart',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: screenWidth * 0.9),
                    child: ElevatedButton(
                        onPressed: () {
                          viewModel.addToCart(product);
                        },
                        child: const Text('Add to Cart')),
                  ),
                ),
                crossFadeState: isInCart ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              );
            }),
          ],
        )));
  }
}
