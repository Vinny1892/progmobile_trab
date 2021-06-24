import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/validators/basic_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';

class RegisterEmployeePage extends StatefulWidget {
  RegisterEmployeePage({Key key, this.title, this.user}) : super(key: key);
  final String id = "";
  User user;
  final String title;

  @override
  _RegisterEmployeePageState createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {
  final TextEditingController email = new TextEditingController();
  final TextEditingController cpf = new TextEditingController();

  final TextEditingController name = new TextEditingController();

  final TextEditingController password = new TextEditingController();
  final TextEditingController address = TextEditingController();

  final TextEditingController passwordVerification =
      new TextEditingController();
  UserController userController = UserController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  bool validPasswordAndPasswordVerificationTheSame(String value) {
    return ((value.length > 0 && passwordVerification.text.length > 0) &&
        value != passwordVerification.text);
  }

  String _validPasswordVerification(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    if (password.text != passwordVerification.text) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  String _validPassword(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    if (validPasswordAndPasswordVerificationTheSame(value)) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white24,
        child: Center(
          child: Container(
            height: 600,
            width: 600,
            child: Form(
              key: _formKey,
              child: Card(
                color: Colors.white,
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "Registrar Novo Funcionario",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextFormField(
                          controller: email,
                          validator: BasicValidator.validEmail,
                          decoration: InputDecoration(
                            labelText: "Digite o email",
                            icon: Icon(Icons.email),
                          )),
                      TextFormField(
                          controller: name,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite  seu nome",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: address,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                            labelText: "Digite o endereço",
                            icon: Icon(Icons.home),
                          )),
                      TextFormField(
                          controller: cpf,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                            labelText: "Digite o CPF",
                            icon: Icon(Icons.credit_card),
                          )),
                      TextPasswordField(
                        validator: _validPassword,
                        controller: password,
                        obscureText: true,
                        labelText: "Digite sua senha",
                      ),
                      TextPasswordField(
                        validator: _validPasswordVerification,
                        controller: passwordVerification,
                        obscureText: true,
                        labelText: "Digite sua senha novamente",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 80)),
                          icon: Icon(Icons.login),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              Map<String, dynamic> data = {
                                "name": name.text,
                                "email": email.text,
                                "address": address.text,
                                "card": {
                                  "name": "",
                                  "number": "",
                                  "securityCode": "",
                                  "validThru": "",
                                },
                                "role": "funcionario",
                                "cpf": cpf.text,
                                "password": password.text
                              };
                              try {
                                User user = await userController.create(data);
                                if (user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Erro ao cadastrar usuario')));
                                } else {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppRoutes.USER_LIST);
                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Erro ao cadastrar usuario')));
                              }
                            }
                          },
                          label: Text("Cadastrar"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: OutlinedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 64)),
                          icon: Icon(Icons.backspace),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.USER_LIST);
                          },
                          label: Text("Voltar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
