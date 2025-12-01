import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../session/user_session.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  User? _user;
  bool _isLoading = false;
  String? _error;

  // =============== REMEMBER ME ===============
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  // ===========================================
  //                 GETTERS
  // ===========================================
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _loadRememberMe();
  }

  // ===========================================
  //           REMEMBER ME FUNCTIONS
  // ===========================================

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('remember_me') ?? false;
    notifyListeners();

    // Optional: Auto-login user saved in prefs
    if (_rememberMe && prefs.containsKey("saved_user_email")) {
      debugPrint("🔄 Auto-fill email from saved RememberMe");

      UserSession.email = prefs.getString("saved_user_email") ?? "";
    }
  }

  Future<void> setRememberMe(bool value) async {
    _rememberMe = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);

    if (!value) {
      await prefs.remove("saved_user_email");
    }
  }

  Future<void> _saveUserRememberMe() async {
    if (!_rememberMe || _user == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("saved_user_email", _user!.email);
  }

  // ===========================================
  //                  LOGIN
  // ===========================================

  Future<void> login({
    String? email,
    String? mobile,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final loggedInUser = await _apiService.login(
        email: email,
        mobile: mobile,
        password: password,
      );

      _user = loggedInUser;

      // =====================================
      //        SAVE TO USER SESSION
      // =====================================
      UserSession.userId = _user!.id;
      UserSession.name = _user!.name;
      UserSession.email = _user!.email;
      UserSession.phone = _user!.mobile;

      debugPrint("✅ LOGIN SUCCESS");
      debugPrint("UserId: ${UserSession.userId}");
      debugPrint("Name  : ${UserSession.name}");
      debugPrint("Email : ${UserSession.email}");
      debugPrint("Phone : ${UserSession.phone}");

      // =====================================
      //      SAVE REMEMBER ME (JIKA ON)
      // =====================================
      await _saveUserRememberMe();
    } catch (e) {
      _error = e.toString();
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
