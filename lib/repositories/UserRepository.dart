import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_session/flutter_session.dart';

class UserRepository {
  Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']));

  Future<bool> logout() async {
    var response = await _dio.post("logout",
        options: Options(headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> login(String email, String password) async {
    print(dotenv.env["BASE_URL"]);
    try {
      Map<String, dynamic> userLogin = {"email": email, "password": password};
      var response = await _dio.post("login",
          data: userLogin,
          options: Options(headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          }));
      if (response.statusCode == 200) {
        print("dentro if 200");
        //print(response.data);
        User user = User.fromJson(response.data);
        //print(user);
        return user;
      } else {
        print("fora if 200");
      }
      return User();
    } catch (e) {
      print(e);
    }
  }
  // Future<User> login(String email, String password) async {
  //   try {
  //     Map<String, dynamic> userLogin = {"email": email, "password": password};
  //     var response = await _dio.post("http://localhost:3000/login/",
  //         data: userLogin,
  //         options: Options(headers: {
  //           "Access-Control-Allow-Origin":
  //               "*", // Required for CORS support to work
  //           "Access-Control-Allow-Credentials":
  //               true, // Required for cookies, authorization headers with HTTPS
  //           "Access-Control-Allow-Headers":
  //               "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  //           "Access-Control-Allow-Methods": "POST, OPTIONS"
  //         }));
  //     if (response.statusCode == 200) {
  //       print("dentro if 200");
  //       // print(response.data);
  //       User user = User.fromJson(response.data);
  //       return user;
  //     } else
  //       print("fora if 200");
  //     return User();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<List<User>> listAllUsers() async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    Response response = await _dio.get("user",
        options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
    List<User> users = (response.data as List).map((item) {
      return User.fromJson(item);
    }).toList();
    return users;
  }

  Future<User> getByID(id) async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    Response response = await _dio.get("user/$id",
        options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
    return User.fromJson(response.data);
  }

  Future<User> create(Map<String, dynamic> user) async {
    Response response = await _dio.post("user",
        data: user,
        options: Options(headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        }));
    print(response.data);
    if (response.statusCode == 200) return User.fromJson(response.data);
    return User();
  }

  Future<User> delete(String id) async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();

    Response response = await _dio.delete("user/$id",
        options: Options(headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              true, // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "DELETE, OPTIONS",
          "Authorization": "Bearer ${user.token}"
        }));
    print(response.data);
    if (response.statusCode == 200) return User.fromJson(response.data);
    return User();
  }
}
