import 'package:ecommerce_frontend/middlewares/auth_middleware.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/view/Login.dart';
import 'package:ecommerce_frontend/view/auth/RegisterClient.dart';
import 'package:ecommerce_frontend/view/auth/RegisterEmployee.dart';
import 'package:ecommerce_frontend/view/cart/showCart.dart';
import 'package:ecommerce_frontend/view/errors/forbidden.dart';
import 'package:ecommerce_frontend/view/order/order_show.dart';
import 'package:ecommerce_frontend/view/product/productList.dart';
import 'package:ecommerce_frontend/view/product/product_form.dart';
import 'package:ecommerce_frontend/view/errors/unknown.dart';
import 'package:ecommerce_frontend/view/user/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'model/User.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.LOGIN,
      onGenerateRoute: (settings) {
        print(settings.name);
        if (settings.name == AppRoutes.USER_LIST) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => AuthMidlleware.authBasic(UserListPage()));
        }
        if (settings.name == AppRoutes.LOGIN) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => AuthMidlleware.guestBasic(LoginPage()));
        }
        if (settings.name == AppRoutes.REGISTER) {
          return MaterialPageRoute(
              builder: (_) => AuthMidlleware.guestBasic(RegisterPage()));
        }
        if (settings.name == AppRoutes.USER_FUNCTIONARY) {
          return MaterialPageRoute(builder: (_) => RegisterEmployeePage());
        }
        if (settings.name == AppRoutes.PRODUCT_LIST) {
          //return MaterialPageRoute(builder: (_) => ProductListPage());
          return MaterialPageRoute(
              builder: (_) => AuthMidlleware.guestBasic(ProductListPage()));
        }

        if (settings.name == AppRoutes.PRODUCT_FORM) {
          var product = settings.arguments;
          return MaterialPageRoute(builder: (context) => ProductForm(product));
        }

        // if (settings.name == AppRoutes.ORDER) {
        //   //var order = settings.arguments;
        //   return MaterialPageRoute(builder: (context) => PayPage());
        // }

        if (settings.name == AppRoutes.CART) {
          return MaterialPageRoute(
              builder: (context) => AuthMidlleware.guestBasic(CartPage()));
        }

        if (settings.name == AppRoutes.CART_FORM) {
          var cart = settings.arguments;
          return MaterialPageRoute(builder: (context) => ProductForm(cart));
        }

        if (settings.name == AppRoutes.ORDER) {
          var cart = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => OrderStatefulWidget(cart: cart));
          //var order = settings.arguments;
          //return MaterialPageRoute(builder: (context) => OrderStatefulWidget(order));
        }

        // unknown route
        return MaterialPageRoute(builder: (_) => UnknownPage());
      },
      // routes: {
      //   AppRoutes.USER_LIST: (_) => UserListPage(),
      //   AppRoutes.HOME: (_) => LoginPage(),
      //   AppRoutes.PRODUCT_FORM: (_) => checkAuthenticate(ProductForm()),
      //   AppRoutes.LOGIN: (_) => LoginPage(),
      //   AppRoutes.PRODUCT_LIST: (_) => checkAuthenticate(ProductListPage()),
      //   AppRoutes.REGISTER: (_) => RegisterPage(),
      // },
    );
  }
}
