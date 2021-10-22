import 'dart:math';

import 'package:alpha_store/models/product.dart';
import 'package:alpha_store/viewmodels/products_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'home_page.dart';
import 'login_page.dart';

class CartPage extends StatelessWidget {
  Widget buildItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: product.image,
            height: 100,
            width: 100,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              debugPrint('error: $error');
              return Icon(Icons.error);
            },
          ),
          Expanded(child: Text(product.title)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('1'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Consumer<ProductsViewModel>(builder: (context, viewModel, child) {
          var items = viewModel.cartItems;

          if (items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No items yet'),
                TextButton(
                  child: Text('Start Shopping'),
                  onPressed: () {
                    openPage(context, HomePage());
                  },
                )
              ],
            );
          }

          return ListView.builder(
            itemBuilder: (_context, index) => buildItem(items[index]),
            itemCount: items.length,
          );
        }),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Place Order'),
              onPressed: () {
                openPage(context, LoginPage());
              },
            ),
          ),
        ),
      ],
    );
  }
}

