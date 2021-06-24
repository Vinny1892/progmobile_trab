import 'package:ecommerce_frontend/shared/store/user_store.dart';

class UserSession {
  static UserStore _userStore = UserStore();

  static UserStore get instance => _userStore;
}
