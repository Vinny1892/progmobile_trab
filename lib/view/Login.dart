import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final UserController userController = UserController();
  final String title;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String _validBasic(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
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
                          "Acesse a  plataforma",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextFormField(
                        controller: email,
                        validator: _validBasic,
                        decoration: InputDecoration(icon: Icon(Icons.person)),
                      ),
                      TextPasswordField(
                        controller: password,
                        validator: _validBasic,
                        obscureText: true,
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
                              await userController.login(
                                  email.text, password.text);
                              print("VIEW");
                              UserStore userStore = UserSession.instance;
                              User user = userStore.getUser();
                              if (user != null) {
                                print("inside navigator");
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.PRODUCT_LIST);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Usuario ou Senha Incorretos')));
                              }
                            }
                          },
                          label: Text("Logar"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: OutlinedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 64)),
                          icon: Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.REGISTER);
                          },
                          label: Text("Registrar"),
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
