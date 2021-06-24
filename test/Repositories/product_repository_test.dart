import 'package:ecommerce_frontend/repositories/ProductRepository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'user_repository_test.dart';

void main() {
  test("ListProductsFuncionando", () async {
    await userRepo.login("admin@admin.com", "admin");
    var products = await ProductRepository().getAll();
  });
}
