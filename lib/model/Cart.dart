import 'package:flutter/material.dart';
import 'Product.dart';

class Cart {
  // final List<Product> productListId;
  final List<dynamic> productListId;
  final String id;
  final String updatedAt;
  final String clientId;
  final bool status;
  List<Product> products;

  Cart(
      {this.productListId,
      this.id,
      this.updatedAt,
      this.clientId,
      this.status});

  bool isActivatedCart(cart) {}
}
