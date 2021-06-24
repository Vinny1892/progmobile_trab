import 'package:ecommerce_frontend/model/User.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User user;

  @action
  User getUser() {
    return this.user;
  }

  @action
  String getToken() {
    return this.user.token;
  }

  @action
  void setUser(User user) {
    this.user = user;
  }
}
