import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/provider/cartItem.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    return Scaffold(
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Container(

            );
          }),
    );
  }
}
