import 'package:ecommerce_frontend/validators/basic_validator.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email;
  TextEditingController name;
  TextEditingController cpf;
  TextEditingController address;
  TextEditingController password;

  TextEditingController passwordVerification;
  final TextEditingController securityCode = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController nameCard = TextEditingController();
  final TextEditingController validThru = TextEditingController();
  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    name = TextEditingController();
    cpf = TextEditingController();
    address = TextEditingController();
    password = TextEditingController();
    passwordVerification = TextEditingController();
  }

  int currentStep = 0;
  bool complete = false;
  var stepStateLogin = StepState.editing;
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

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
          title: Text("Novo usuario"),
          isActive: true,
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
                        icon: Icon(Icons.person))),
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
          title: Text("Novo usuario 2"),
          isActive: true,
          state: stepStateCard,
          content: Form(
            key: _formKeys[1],
            child: Column(
              children: [
                TextFormField(
                    controller: securityCode,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite o cvv do cartão",
                        icon: Icon(Icons.person))),
                TextFormField(
                    controller: number,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite o numero do cartao",
                        icon: Icon(Icons.person))),
                TextFormField(
                    controller: nameCard,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite o nome que está no cartão ",
                        icon: Icon(Icons.person))),
                TextFormField(
                    controller: validThru,
                    validator: BasicValidator.validBasic,
                    decoration: InputDecoration(
                        labelText: "Digite a validade do cartao",
                        icon: Icon(Icons.person))),
              ],
            ),
          ))
    ];
    return Scaffold(
      body: Column(
        children: [
          Stepper(
            steps: steps,
            currentStep: currentStep,
            onStepContinue: () {
              print(" currentStep $currentStep");
              if (_formKeys[currentStep].currentState.validate() &&
                  currentStep < 1) {
                setState(() => currentStep += 1);
              }

              if (currentStep == 1) {
                // send formulario
                print(number.text);
              }
            },
            onStepCancel: () {
              currentStep > 0 ? setState(() => currentStep -= 1) : null;
            },
          ),
        ],
      ),
    );
  }
}
