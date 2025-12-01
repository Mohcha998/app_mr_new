import 'dart:convert';
import 'package:http/http.dart' as http;

class BirdtestResultService {
  final String _apiUrl =
      'https://apps.mri.co.id/Guestbirdtest/getresult_birdtest';

  Future<Map<String, dynamic>?> getTestResult(String email) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // Pastikan response sesuai format
        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          return jsonResponse;
        } else {
          return null;
        }
      } else {
        // Jika status code tidak 200
        return null;
      }
    } catch (e) {
      print('Error fetching Bird Test result: $e');
      return null;
    }
  }
}
