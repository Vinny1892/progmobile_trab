import 'package:ecommerce_frontend/repositories/UserRepository.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';

class UserController {
  UserRepository userRepository = UserRepository();

  Future<List<User>> listAll() {
    return userRepository.listAllUsers();
  }

  Future<User> login(String email, String password) async {
    User user = await userRepository.login(email, password);
    UserStore userStore = UserSession.instance;
    userStore.setUser(user);
    return user;
  }

  Future<User> getByID(String id) async {
    User user = await userRepository.getByID(id);
    return user;
  }

  Future<User> create(Map<String, dynamic> data) async {
    User user = await userRepository.create(data);
    return user;
  }

  Future<User> delete(String id) async {
    return await userRepository.delete(id);
  }

  Future<bool> logout() async {
    return await userRepository.logout();
  }
}
