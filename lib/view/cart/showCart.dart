import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:flutter/material.dart';
import '../../model/Cart.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => new _CartPageState();
}


class _CartPageState extends State<CartPage> {
  UserStore userStore = UserSession.instance;
  User user = User();
  Cart cart;
  CartController cartController = CartController();
  ProductController productController = ProductController();
  StreamController<Cart> streamController = StreamController<Cart>();
  @override
  void initState() {
    super.initState();
    user = userStore.getUser();
    print("aqui");
    _loadCartAndProducts();
  }

  void dispose() {
    super.dispose();
    streamController.close();
  }

  void _loadCartAndProducts() async {
    Cart cart = await cartController.getCartByClientId(user.id);
    streamController.sink.add(cart);
    cart.products =
        await ProductController().getProductsByCart(cart.productListId);
    streamController.sink.add(cart);
  }


  // void _removeProductCart(String id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('Carrinho'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.PRODUCT_LIST);
              })
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<Cart>(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
            if (snapshot.hasData) {
              Cart data = snapshot.data;
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Carrinho do ${user.name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    if (data.products != null && data.products.length != 0)
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(data.products[index].name);
                                return ListTile(
                                  title: Text(data.products[index].name),
                                  trailing: Container(
                                      width: 100,
                                      child: Row(children: [
                                        IconButton(
                                            icon: Icon(
                                                Icons.remove_shopping_cart),
                                            onPressed: () {}),
                                      ])),
                                );
                              }))
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
