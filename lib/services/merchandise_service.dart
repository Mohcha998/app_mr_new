import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/merchandise_item.dart';
import '../models/merchandise_by_type.dart';
import '../models/merchandise_group.dart';

class MerchandiseService {
  final String baseUrl = ApiConstants.baseUrl;

  // ----------------------------------------------------------
  // GET ALL MERCHANDISE
  // ----------------------------------------------------------
  Future<List<MerchandiseGroup>> getAllMerchandise() async {
    final url = Uri.parse("$baseUrl/merchandise");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load merchandise");
    }

    final data = jsonDecode(response.body);

    final list = (data["merchandise_all"] as List)
        .map((e) => MerchandiseGroup.fromJson(e))
        .toList();

    return list;
  }

  // ----------------------------------------------------------
  // GET PRIMERRY
  // ----------------------------------------------------------
  Future<List<MerchandiseGroup>> getPrimerry() async {
    final url = Uri.parse("$baseUrl/merchandise/primerry");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load Primerry");
    }

    final data = jsonDecode(response.body);

    return (data["merchandise_all"] as List)
        .map((e) => MerchandiseGroup.fromJson(e))
        .toList();
  }

  // ----------------------------------------------------------
  // GET MZ
  // ----------------------------------------------------------
  Future<List<MerchandiseGroup>> getMZ() async {
    final url = Uri.parse("$baseUrl/merchandise/mz");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load MZ");
    }

    final data = jsonDecode(response.body);

    return (data["merchandise_all"] as List)
        .map((e) => MerchandiseGroup.fromJson(e))
        .toList();
  }

  // ----------------------------------------------------------
  // GET BY TYPE (Books, Fashion, Others)
  // ----------------------------------------------------------
  Future<List<MerchandiseByType>> getByTipe(int id) async {
    final url = Uri.parse("$baseUrl/merchandise/bytipe?id=$id");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load merchandise by type");
    }

    final data = jsonDecode(response.body);

    final list = (data["merchandise"] as List)
        .map((e) => MerchandiseByType.fromJson(e))
        .toList();

    return list;
  }
}
