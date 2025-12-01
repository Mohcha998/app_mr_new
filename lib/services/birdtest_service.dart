import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../session/user_session.dart';

class BirdtestService {
  final String apiMriUrl =
      'https://apps.mri.co.id/Guestbirdtest/submit_birdtest';
  final String apiLocalUrl =
      'http://localhost:8080/api/v1/birdtest/update_status';

  Future<void> submitTest({
    required String nama,
    required String email,
    required String phone,
    required Map<String, int> scores,
    required Map<int, int> answers,
  }) async {
    final mriBody = {
      "nama": nama,
      "email": email,
      "phone": phone,
      "dove": scores['dove'] ?? 0,
      "owl": scores['owl'] ?? 0,
      "peacock": scores['peacock'] ?? 0,
      "eagle": scores['eagle'] ?? 0,
      "log": answers.values.join(","), // ⚠️ ubah ke string
    };

    final localBody = {"user_id": UserSession.userId};

    final headers = {"Content-Type": "application/json"};

    try {
      final responses = await Future.wait([
        http.post(
          Uri.parse(apiMriUrl),
          headers: headers,
          body: jsonEncode(mriBody),
        ),
        http.put(
          Uri.parse(apiLocalUrl),
          headers: headers,
          body: jsonEncode(localBody),
        ),
      ]);

      debugPrint('MRI Response: ${responses[0].statusCode}');
      debugPrint('Local Response: ${responses[1].statusCode}');

      if (responses.any((res) => res.statusCode >= 400)) {
        throw Exception('Ada error saat submit birdtest');
      }
    } catch (e) {
      debugPrint('Error submit birdtest: $e');
      rethrow;
    }
  }
}
