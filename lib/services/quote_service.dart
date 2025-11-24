import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/quote_model.dart';

class QuoteService {
  Future<Quote> getTodayQuote(int userId) async {
    final url = "${ApiConstants.baseUrl}/quotes/today/$userId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Quote.fromJson(data['data']);
    } else {
      throw Exception("Gagal mengambil quote: ${response.body}");
    }
  }
}
