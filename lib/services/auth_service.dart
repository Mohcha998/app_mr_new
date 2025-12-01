import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/user_model.dart';

class ApiService {
  /// ------------------------------
  /// LOGIN
  /// ------------------------------
  Future<User> login({
    String? email,
    String? mobile,
    required String password,
  }) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}/login");

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        if (email != null && email.isNotEmpty) "email": email,
        if (mobile != null && mobile.isNotEmpty) "mobile": mobile,
        "password": password,
      }),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["success"] == true) {
      final userJson = body["data"];
      final user = User.fromJson(userJson);

      print("LOGIN SUCCESS:");
      print("Name  : ${user.name}");
      print("Email : ${user.email}");
      print("Phone : ${user.mobile}");

      return user;
    } else {
      throw Exception(body["message"] ?? "Login gagal");
    }
  }

  /// ------------------------------
  /// CHECK USER BY EMAIL
  /// ------------------------------
  Future<User?> checkByEmail(String email) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}/user/check-by-email/$email");

    final response = await http.get(uri);

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["success"] == true) {
      final userJson = body["data"];
      return User.fromJson(userJson);
    } else {
      return null; // Email tidak ditemukan
    }
  }

  /// ------------------------------
  /// UPDATE PASSWORD (FORGET PASSWORD)
  /// ------------------------------
  Future<bool> updatePassword(String email, String newPassword) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}/user/update-password/$email",
    );

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"password": newPassword}),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200 && body["success"] == true) {
      return true;
    } else {
      throw Exception(body["message"] ?? "Gagal update password");
    }
  }
}
