import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final ApiService api = ApiService();

  Future<User> loginWithEmail(String email, String password) async {
    return await api.login(email: email, password: password);
  }

  Future<User> loginWithMobile(String mobile, String password) async {
    return await api.login(mobile: mobile, password: password);
  }
}
