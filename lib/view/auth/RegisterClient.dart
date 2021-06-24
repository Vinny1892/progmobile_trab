import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/validators/basic_validator.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String id = "";
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserController userController = UserController();
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  final TextEditingController address = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController passwordVerification = TextEditingController();
  final TextEditingController securityCode = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController nameCard = TextEditingController();
  final TextEditingController validThru = TextEditingController();

  int currentStep = 0;
  bool complete = false;
  var stepStateLogin = StepState.indexed;
  var stepStateCard = StepState.indexed;

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

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

  String messageShowUserWhenRegisterIsComplete =
      "Usuario criado com sucesso :)";

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
          title: Text("Novo usuario"),
          isActive: true,
          subtitle: Text("Cadastro de usuario"),
          state: stepStateLogin,
          content: Form(
            key: _formKeys[0],
            child: Column(
              children: [
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
                    controller: cpf,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite  seu CPF",
                        icon: Icon(Icons.person))),
                TextFormField(
                    controller: address,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite  seu endereço",
                        icon: Icon(Icons.house))),
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
              ],
            ),
          )),
      Step(
          title: Text("Cadastrar Cartão"),
          isActive: true,
          state: stepStateCard,
          content: Form(
            key: _formKeys[1],
            child: Column(
              children: [
                TextFormField(
                    controller: securityCode,
                    decoration: InputDecoration(
                        labelText: "Digite o CVV do cartão",
                        icon: Icon(Icons.security))),
                TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                        labelText: "Digite o numero do cartao",
                        icon: Icon(Icons.credit_card_rounded))),
                TextFormField(
                    controller: nameCard,
                    decoration: InputDecoration(
                        labelText: "Digite o nome que está no cartão",
                        icon: Icon(Icons.person))),
                TextFormField(
                    controller: validThru,
                    decoration: InputDecoration(
                        labelText: "Digite a validade do cartao",
                        icon: Icon(Icons.calendar_today))),
              ],
            ),
          )),
      Step(
          isActive: true,
          title: Text("Finalização Cadastro Usuario"),
          content: Text(messageShowUserWhenRegisterIsComplete))
    ];
    return Scaffold(
      body: Container(
        color: Colors.white24,
        child: Center(
          child: Container(
            height: 700,
            width: 800,
            child: Card(
                child: Column(
              children: [
                Expanded(
                  child: Stepper(
                    steps: steps,
                    currentStep: currentStep,
                    onStepTapped: (step) {
                      setState(() => currentStep = step);
                    },
                    onStepContinue: () async {
                      print(" currentStep $currentStep");
                      if (currentStep < 2 &&
                          _formKeys[0].currentState.validate()) {
                        setState(() => currentStep += 1);
                      }
                      if (currentStep >= 2) {
                        print(" send formulario");
                        var data = {
                          "name": name.text,
                          "password": password.text,
                          "cpf": cpf.text,
                          "address": address.text,
                          "email": email.text,
                          "card": {
                            "name": nameCard.text,
                            "securityCode": securityCode.text,
                            "validThru": validThru.text,
                            "number": number.text
                          },
                          "role": "cliente",
                        };
                        try {
                          User user = await userController.create(data);
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Erro ao cadastrar usuario')));
                          } else {
                            setState(() =>
                                this.messageShowUserWhenRegisterIsComplete =
                                    "Usuario criado com sucesso :)");

                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.LOGIN);
                          }
                        } catch (e) {
                          setState(() {
                            this.messageShowUserWhenRegisterIsComplete =
                                "Erro na hora de cadastrar usuario verifique se o email ja não esta cadastrado, em caso de duvida contate o kaio";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Erro ao cadastrar usuario')));
                        }
                      }
                    },
                    onStepCancel: () {
                      currentStep > 0 ? setState(() => currentStep -= 1) : null;
                    },
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
