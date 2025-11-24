import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/user_model.dart';

class ApiService {
  Future<User> login({
    String? email,
    String? mobile,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email ?? "",
        "mobile": mobile ?? "",
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Email/HP atau password salah");
    } else if (response.statusCode == 404) {
      throw Exception("User tidak ditemukan");
    } else {
      throw Exception("Login gagal: ${response.body}");
    }
  }
}
