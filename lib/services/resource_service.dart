import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/resource_model.dart';
import '../core/constants.dart';

class ResourceService {
  static Future<List<ResourceModel>> getResources() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/resources"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data["freeResources"];

        return items.map((e) => ResourceModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching resources: $e");
      return [];
    }
  }
}
