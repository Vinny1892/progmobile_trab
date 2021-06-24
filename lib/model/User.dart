import 'package:ecommerce_frontend/model/Card.dart';

class User {
  String _id;
  String _name;
  String _email;
  String _cpf;
  String _address;
  Card _card;
  String _role;
  String _password;
  String _token;

  User(
      {String id,
      String name,
      String email,
      String cpf,
      String address,
      Card card,
      String password,
      String token}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._cpf = cpf;
    this._address = address;
    this._card = card;
    this._role = role;
    this._password = password;
    this._token = token;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  String get cpf => _cpf;
  set cpf(String cpf) => _cpf = cpf;
  String get address => _address;
  set address(String address) => _address = address;
  Card get card => _card;
  set card(Card card) => _card = card;
  String get role => _role;
  set role(String role) => _role = role;
  String get password => _password;
  set password(String password) => _password = password;
  String get token => _token;
  set token(String token) => _token = token;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _cpf = json['cpf'];
    _address = json['address'];
    _card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    _role = json['role'];
    _password = json['password'];
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['cpf'] = this._cpf;
    data['address'] = this._address;
    if (this._card != null) {
      data['card'] = this._card.toJson();
    }
    data['role'] = this._role;
    data['password'] = this._password;
    data['token'] = this._token;
    return data;
  }
}
