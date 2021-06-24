//import 'package:flutter/material.dart';

// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final String provider_cnpj;
//   final String description;

//   Product(
//       {this.id, this.name, this.price, this.provider_cnpj, this.description});

//   // @override
//   // String toString() {
//   //   // TODO: implement toString
//   //   return id + name;
//   // }
// }
class Product {
  int id;
  String name;
  double price;
  String provider_cnpj;
  String description;

  Product(
      {this.id, this.name, this.price, this.provider_cnpj, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    provider_cnpj = json['provider_cnpj'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['provider_cnpj'] = this.provider_cnpj;
    data['description'] = this.description;
    return data;
  }
}
