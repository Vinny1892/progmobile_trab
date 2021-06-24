import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/controller/OrderController.dart';
import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/repositories/UserRepository.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:flutter/material.dart';
import '../../model/Product.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => new _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products;

  UserStore userStore = UserSession.instance;
  User user;
  StreamController streamController = StreamController();

  @override
  void initState() {
    super.initState();
    this.user = userStore.getUser();
    _loadProducts();
  }

  void _loadProducts() async {
    this.products = await ProductController().get_all();
    streamController.sink.add(products);
  }

  void _removeProduct(int id) async {
    await ProductController().delete(id);
    this.products = await ProductController().get_all();
    streamController.sink.add(products);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  //print(user.role);

  @override
  Widget build(BuildContext context) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    String userId = user.id;
    List<Widget> buttonPerUser(Product product) {
      //if (product.user.type == 'funcionario') {
      if (this.user.role == "funcionario") {
        return [
          IconButton(
              icon: new Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product);
              }),
          IconButton(
              icon: new Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir usuario'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                _removeProduct(product.id);
                              },
                            ),
                          ],
                        ));
              })
        ];
      } else {
        return [
          IconButton(
              icon: new Icon(Icons.add_shopping_cart),
              color: Colors.green,
              onPressed: () async {
                print("tela listar produto indo pro carrinho");
                bool response =
                    await new CartController().addProduct(product, userId);
                print(response);
                String msg = "Erro ao adicionar produto ao carrinho";
                if (response) {
                  msg = "Produto adicionado carrinho com sucesso";
                }
                AlertDialog(
                  title: Text(msg),
                );
              }),
        ];
      }
    }

    List<Widget> meunuButtonPerUser() {
      List<Widget> listMenu = List<Widget>();

      if (this.user.role == "funcionario") {
        listMenu = [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.USER_LIST),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //Coloca tela form por cima, e depois remove da pilha de telas
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              }),
        ];
      } else {
        listMenu = [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.CART);
              }),
          IconButton(
              icon: new Icon(Icons.attach_money),
              color: Colors.yellowAccent,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Finalizar compra'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () async {
                                Cart cart = await new CartController()
                                    .getCartByClientId(user.id);
                                Navigator.of(context).pushNamed(AppRoutes.ORDER,
                                    arguments: cart);
                                //Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              })
        ];
      }
      listMenu.add(IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            UserStore userStore = UserSession.instance;
            userStore.setUser(null);
            Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
          }));
      return listMenu;
    }

    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('Produtos'),
        actions: meunuButtonPerUser(),
      ),
      body: Container(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  return Card(
                      child: ListTile(
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text("Preço: " + data.price.toString()),
                    trailing: Container(
                        width: 100,
                        child: Row(
                          children: buttonPerUser(data),
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(data)));
                      //builder: (context) => DetailPage(product: data)));
                    },
                  ));
                },
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

// detalhes de um produto
class DetailPage extends StatelessWidget {
  final Product product;
  //const ProductTile(this.product);
  DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Descrição: ${product.description}",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                "Preço: ${product.price}",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                "CNPJ do fornecedor: ${product.provider_cnpj}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ));
  }
}

//Text(product.price.toString()),
