import 'dart:math';

import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  Dio _dio = Dio();

  // Future<Order> finalShop(Cart cart) async {
  //   Order order;
  //   try {
  //     UserStore userStore = UserSession.instance;
  //     User user = userStore.getUser();
  //     var response = await _dio.post('http://localhost:3000/order',
  //         data: {'cartId': cart.id},
  //         options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
  //     var data = response.data;
  //     print(data);
  //     order = Order.fromJson(response.data);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return order;
  // }

  Future<Order> finalShop(Cart cart) async {
    Order order;
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await _dio.get('http://localhost:3000/order?id=2',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
      var data = response.data;
      order = Order.fromJson(response.data[0]);
      print(order);
    } catch (e) {
      print(e);
    }
    return order;
  }
}
