import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  Product product;
  ProductForm(this.product);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

  void _loadFormData(Product product) {
    if (product != null) {
      _formData['id'] = product.id;
      _formData['name'] = product.name;
      _formData['description'] = product.description;
      _formData['price'] = product.price.toString();
      _formData['provider_cnpj'] = product.provider_cnpj;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Product product = ModalRoute.of(context).settings.arguments;
    _loadFormData(widget.product);
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de produto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                //remove essa tela atual da pilha de telas, voltando para tela anterior
                //_form.currentState.validate();
                final isValid = _form.currentState.validate();
                if (isValid) {
                  _form.currentState.save();
                  Product product = new Product(
                      id: _formData['id'],
                      name: _formData['name'] as String,
                      price: ((_formData['price']) as double) + .0,
                      provider_cnpj: _formData['provider_cnpj'] as String,
                      description: _formData['description'] as String);
                  if (product.id == null) {
                    await new ProductController().post(product);
                  } else {
                    await new ProductController().put(product);
                  }
                  // print(error);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.PRODUCT_LIST);
                }
              })
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => _formData['name'] = value,
                ),
                TextFormField(
                  initialValue: _formData['price'],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Preço'),
                  onSaved: (value) =>
                      _formData['price'] = (double.parse(value)) + .0,
                ),
                TextFormField(
                  initialValue: _formData['provider_cnpj'],
                  decoration: InputDecoration(labelText: 'CNPJ do fornecedor'),
                  onSaved: (value) => _formData['provider_cnpj'] = value,
                ),
                TextFormField(
                  initialValue: _formData['description'],
                  decoration: InputDecoration(labelText: 'Descrição'),
                  onSaved: (value) => _formData['description'] = value,
                ),
              ],
            ),
          )),
    );
  }
}
