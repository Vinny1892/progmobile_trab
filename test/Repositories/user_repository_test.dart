import 'package:ecommerce_frontend/repositories/UserRepository.dart';
import 'package:flutter_test/flutter_test.dart';

UserRepository userRepo = UserRepository();

void main() {
  test("Login", () async {
    var user =
        await userRepo.login("wilson@manjaro.com", "doteiroquenaousamanjaro");
    expect(user.email, "wilson@manjaro.com");
  });

  test("ListUsersFuncionando", () async {
    await userRepo.login("wilson@manjaro.com", "doteiroquenaousamanjaro");
    var users = await userRepo.listAllUsers();
    print(users);
    expect(users[0].email, "teste@teste5.com");
  });

  test("CreateUsersFuncionando", () async {
    //await userRepo.login("teste@teste.com", "12345");
    Map<String, dynamic> data = {
      "name": "Lucas Sandim",
      "email": "wilson@manjaro.com",
      "cpf": "023234141",
      "address": "mora na merda",
      "password": "doteiroquenaousamanjaro",
      "role": "cliente",
      "card": {
        "name": "Jessica",
        "securityCode": "666",
        "validThru": "29/13",
        "number": "12342345234"
      }
    };
    var users = await userRepo.create(data);
    print(users);
    expect(users.email, "wilson@manjaro.com");
  });
}
