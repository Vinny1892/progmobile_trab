import 'package:ecommerce_frontend/model/Product.dart';

class Order {
  int id;
  double totalPrice;
  int paymentMethod;
  int clientId;
  List<Product> products;

  Order({int id, int paymentMethod, int clientId, List<Product> products}) {
    this.paymentMethod = paymentMethod;
    this.clientId = clientId;
    this.products = products;
    if (id != null) {
      this.id = id;
    }
    this.totalPrice = _calcTotalPrice(this.products);
  }

  double _calcTotalPrice(List<Product> products) {
    double totalPrice = 0.0;
    for (Product product in products) {
      totalPrice += product.price;
    }
    return totalPrice;
  }

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    clientId = json['clientId'];
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
    data['clientId'] = this.clientId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
