import 'package:alpha_store/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: screenWidth * 0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add to Cart'),
                ),
              ),
            )
          ],
        )));
  }
}
