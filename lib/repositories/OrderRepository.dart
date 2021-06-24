import 'dart:math';

import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderRepository {
  Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']));

  Future<Order> finalShop(Cart cart) async {
    Order order;
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await _dio.get('order?id=2',
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
