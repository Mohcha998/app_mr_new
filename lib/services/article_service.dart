import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/article_model.dart';

class ArticleService {
  // endpoint article
  static String get latestArticlesUrl =>
      "${ApiConstants.baseUrl}/articles/latest";

  static const String imageBase = "https://article.merryriana.com/";

  static Future<List<Article>> getLatestArticles() async {
    final response = await http.get(Uri.parse(latestArticlesUrl));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List data = jsonBody['data'];
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load articles: ${response.statusCode}");
    }
  }

  // Untuk generate full URL gambar
  static String fullImageUrl(String path) {
    if (path.startsWith("http")) return path;
    return "$imageBase$path";
  }
}
