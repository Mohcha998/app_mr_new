import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/ads_popup_model.dart';

class AdsService {
  static Future<AdsPopupModel?> getPopup() async {
    final url = Uri.parse("${ApiConstants.baseUrl}/popup");

    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return AdsPopupModel.fromJson(data);
    }

    return null;
  }
}
