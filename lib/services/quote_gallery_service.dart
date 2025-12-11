import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_gallery_model.dart';
import '../core/constants.dart';

class QuoteGalleryService {
  static String endpoint = "${ApiConstants.baseUrl}/gallery";

  static Future<Map<String, List<QuoteGallery>>> fetchGallery() async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode != 200) {
      throw Exception("Failed to load quotes");
    }

    final data = jsonDecode(response.body);

    Map<String, dynamic> categories = data["data"];

    Map<String, List<QuoteGallery>> result = {};

    categories.forEach((key, value) {
      result[key] = (value as List)
          .map((item) => QuoteGallery.fromJson(item))
          .toList();
    });

    return result;
  }
}
