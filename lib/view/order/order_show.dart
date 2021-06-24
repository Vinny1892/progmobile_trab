import 'package:ecommerce_frontend/controller/OrderController.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatefulWidget extends StatefulWidget {
  final Cart cart;
  const OrderStatefulWidget({Key key, this.cart}) : super(key: key);
  @override
  _OrderStatefulWidgetState createState() => _OrderStatefulWidgetState(cart);
}

class _OrderStatefulWidgetState extends State<OrderStatefulWidget> {
  final Cart cart;
  _OrderStatefulWidgetState(this.cart);
  var orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Produtos'),
        //actions: meunuButtonPerUser(),
      ),
      body: Container(
        child: FutureBuilder(
          future: orderController.finalShop(cart),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var order = snapshot.data;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nome do cliente: ${order.client.name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Preço total: ${order.totalPrice}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Metodo de pagamento: ${order.paymentMethod}",
                      style: TextStyle(fontSize: 20),
                    ),
                    ListView.builder(
                      itemCount: snapshot.data.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product = snapshot.data.products[index];
                        //var data = snapshot.data[index];
                        return Card(
                            child: ListTile(
                          title: Text(
                            product.name,
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text("Preço: " + product.price.toString()),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => DetailPage(product)));
                          },
                        ));
                      },
                    ),
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
