import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class PersonalityService {
  Future<int> getBirdtestStatus(String email) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/birdtest/status");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return int.tryParse(data['is_birdtest'].toString()) ?? 0;
    } else {
      throw Exception("(${response.statusCode}) ${response.body}");
    }
  }
}
