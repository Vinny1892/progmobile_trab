import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:flutter/foundation.dart';

class Order {
  String id;
  String totalPrice;
  String paymentMethod;
  Client client;
  List<Product> products;

  Order(
      {this.id,
      this.totalPrice,
      this.paymentMethod,
      this.client,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['products'] != null) {
      products = new List<Product>();
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalPrice'] = this.totalPrice;
    data['paymentMethod'] = this.paymentMethod;
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  int id;
  String cpf;
  String name;

  Client({this.id, this.cpf, this.name});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpf = json['cpf'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cpf'] = this.cpf;
    data['name'] = this.name;
    return data;
  }
}
