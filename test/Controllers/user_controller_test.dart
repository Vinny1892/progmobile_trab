import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';

UserController userController = UserController();

void main() {
  test("Login Controller", () async {
    var user = await userController.login("teste@teste.com", "12345");
    expect(user.email, "teste@teste.com");
  });
}
