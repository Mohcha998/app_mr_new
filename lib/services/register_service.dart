import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class RegisterService {
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "mobile": mobile,
          "password": password,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "data": jsonData};
      } else {
        return {
          "success": false,
          "message": jsonData["message"] ?? "Register gagal",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Kesalahan jaringan: $e"};
    }
  }
}
