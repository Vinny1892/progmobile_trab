import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//updateAddOneProduct
class CartRepository {
  Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']));

  //o microservico cart, recebe 1 productId e o add ao array de productsId
  Future<bool> addProduct(String productID, String clientID) async {
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await _dio.post('cart',
          options: Options(headers: {
            "Authorization": "Bearer ${user.token}",

            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          }),
          data: {
            'client_id': clientID,
            'product_list': [productID],
          });
      print(response.data);
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<Cart> getCartByClientId(String clientId) async {
    Cart cart;
    print(dotenv.env["BASE_URL"]);
    print(clientId);
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      print("ANTES da request");
      var response = await _dio.get('cart/client/$clientId',
          options: Options(headers: {
            "Authorization": "Bearer ${user.token}",

            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "GET, OPTIONS"
          }));
      var data = response.data;
      print(data);

      cart = new Cart(
          productListId: data["product_list"],
          id: data["id"].toString(),
          updatedAt: data["updateAt"],
          clientId: data["client_id"],
          status: data["status"]);
      return cart;
    } catch (e) {
      print(e);
    }
    return cart;
  }

  Future<Cart> getCart(String id) async {
    Cart cart;
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();

      var response = await _dio.get('cart/$id',
          options: Options(headers: {
            "Authorization": "Bearer ${user.token}",

            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "GET, OPTIONS"
          }));
      var data = response.data;
      cart = new Cart(
          productListId: data["product_list"],
          id: data["id"].toString(),
          updatedAt: data["updatedAt"],
          clientId: data["clientId"],
          status: data["status"]);
      return Future<Cart>.value(cart);
    } catch (e) {
      print(e);
    }
    return cart;
  }
}
