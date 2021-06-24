import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/repositories/OrderRepository.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';

class OrderController {
  Future<Order> finalShop(Cart cart) async {
    var response = new OrderRepository().finalShop(cart);
    return response;
  }
}
