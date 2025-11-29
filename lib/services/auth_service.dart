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
      /// ✅ PENTING: ambil body["data"]
      final userJson = body["data"];

      final user = User.fromJson(userJson);

      /// ✅ DEBUG (hapus nanti kalau mau)
      print("LOGIN SUCCESS:");
      print("Name  : ${user.name}");
      print("Email : ${user.email}");
      print("Phone : ${user.mobile}");

      return user;
    } else {
      throw Exception(body["message"] ?? "Login gagal");
    }
  }
}
