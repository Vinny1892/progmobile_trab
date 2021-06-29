import 'dart:async';

import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/controller/OrderController.dart';
import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/view/components/DropDownButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatefulWidget extends StatefulWidget {
  final Cart cart;
  const OrderStatefulWidget({Key key, this.cart}) : super(key: key);
  @override
  _OrderStatefulWidgetState createState() => _OrderStatefulWidgetState(cart);
}

class _OrderStatefulWidgetState extends State<OrderStatefulWidget> {
  Cart cart;
  UserStore userStore = UserSession.instance;
  User user = User();
  StreamController<Order> _streamController = StreamController<Order>();
  List<Product> products;
  _OrderStatefulWidgetState(Cart cart) {
    this.cart = cart;
  }

  void initState() {
    super.initState();
    user = userStore.getUser();
    _initComponent(this.cart);
  }

  void _initComponent(Cart cart) async {
    this.products =
        await ProductController().getProductsByCart(cart.productListId);
    Order order = Order(
        clientId: this.cart.clientId,
        paymentMethod: 0,
        products: this.products);
    _streamController.sink.add(order);
  }

  //var orderController = OrderController();
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  _checkout(Cart cart) async {
    bool isCartStatusUpdatedChange =
        await CartController().changeStatusCartToFalse(cart.id, false);
    if (isCartStatusUpdatedChange)
      Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCT_LIST);
    if (!isCartStatusUpdatedChange)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Falha ao finalizar compra')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: Container(
        child: StreamBuilder<Order>(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<Order> snapshot) {
            if (snapshot.hasData) {
              var order = snapshot.data;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nome do cliente: ${user.name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Preço total: ${order.totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Metodo de pagamento:",
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(padding: EdgeInsets.only(right: 20)),
                          DropDownButton(items: ["Cartão", "Dinheiro"]),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product product = snapshot.data.products[index];
                            return Card(
                                child: ListTile(
                              title: Text(
                                product.name,
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle:
                                  Text("Preço:   ${product.price.toString()}"),
                              onTap: () {
                                _checkout(cart);
                              },
                            ));
                          },
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20),
                    // ),
                    ElevatedButton(
                        onPressed: () {
                          _checkout(this.cart);
                        },
                        child: Text("Finalizar Compra"))
                  ],
                ),
              );
            } else {
              return Container(child: Center(child: Text("Loading...")));
            }
          },
        ),
      ),
    );
  }
}
