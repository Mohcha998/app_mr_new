import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/merchandise_item.dart';
import '../models/merchandise_group.dart';
import '../models/merchandise_by_type.dart';

class MerchandiseService {
  final String baseUrl = ApiConstants.baseUrl;

  // ==========================================================
  // HELPER — FLATTEN BRAND RESPONSE (AMAN)
  // dipakai oleh MZ & MRS
  // ==========================================================
  List<MerchandiseItem> _extractFlatProducts(dynamic json) {
    if (json == null || json['merchandise'] == null) {
      return [];
    }

    final List brands = json['merchandise'];
    final List<MerchandiseItem> items = [];

    for (final brand in brands) {
      if (brand == null || brand['merchandise'] == null) continue;

      final List products = brand['merchandise'];

      for (final p in products) {
        if (p == null) continue;
        items.add(MerchandiseItem.fromJson(p));
      }
    }

    return items;
  }

  // ==========================================================
  // GET ALL MERCHANDISE (GROUPED)
  // endpoint: /merchandise
  // response: merchandise_all[]
  // ==========================================================
  Future<List<MerchandiseGroup>> getAllMerchandise() async {
    final uri = Uri.parse('$baseUrl/merchandise');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load merchandise');
    }

    final json = jsonDecode(response.body);

    final list = json['merchandise_all'];
    if (list == null) return [];

    return (list as List).map((e) => MerchandiseGroup.fromJson(e)).toList();
  }

  // ==========================================================
  // GET ALL MERCHANDISE (FLAT)
  // endpoint: /merchandise/all
  // ==========================================================
  Future<List<MerchandiseItem>> getAllFlat() async {
    final uri = Uri.parse('$baseUrl/merchandise/all');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load merchandise');
    }

    final json = jsonDecode(response.body);
    final list = json['merchandise'];

    if (list == null) return [];

    return (list as List).map((e) => MerchandiseItem.fromJson(e)).toList();
  }

  // ==========================================================
  // GET PRIMERRY (GROUP)
  // ==========================================================
  Future<List<MerchandiseGroup>> getPrimerry() async {
    final uri = Uri.parse('$baseUrl/merchandise/primerry');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load Primerry');
    }

    final json = jsonDecode(response.body);
    final list = json['merchandise_all'];

    if (list == null) return [];

    return (list as List).map((e) => MerchandiseGroup.fromJson(e)).toList();
  }

  // ==========================================================
  // GET PRIMERRY (FLAT)
  // ==========================================================
  Future<List<MerchandiseItem>> getPrimerryFlat() async {
    final groups = await getPrimerry();
    return groups.expand((g) => g.products).toList();
  }

  // ==========================================================
  // GET MANZONE (FLAT) ✅
  // ==========================================================
  Future<List<MerchandiseItem>> getMZFlat() async {
    final uri = Uri.parse('$baseUrl/merchandise/mz');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load Manzone');
    }

    final json = jsonDecode(response.body);
    return _extractFlatProducts(json);
  }

  // ==========================================================
  // GET MR SHOP (FLAT) ✅
  // ==========================================================
  Future<List<MerchandiseItem>> getMrsFlat() async {
    final uri = Uri.parse('$baseUrl/merchandise/mrs');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load MR Shop');
    }

    final json = jsonDecode(response.body);
    return _extractFlatProducts(json);
  }

  // ==========================================================
  // GET BY TYPE
  // ==========================================================
  Future<List<MerchandiseByType>> getByTipe(int id) async {
    final uri = Uri.parse('$baseUrl/merchandise/bytipe?id=$id');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load merchandise by type');
    }

    final json = jsonDecode(response.body);
    final list = json['merchandise'];

    if (list == null) return [];

    return (list as List).map((e) => MerchandiseByType.fromJson(e)).toList();
  }

  // ==========================================================
  // GET BY ID
  // ==========================================================
  Future<MerchandiseItem?> getById(int id) async {
    final uri = Uri.parse('$baseUrl/merchandise/byid?id=$id');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load merchandise by ID');
    }

    final json = jsonDecode(response.body);
    final list = json['merchandise'];

    if (list == null || list.isEmpty) return null;

    return MerchandiseItem.fromJson(list.first);
  }
}
