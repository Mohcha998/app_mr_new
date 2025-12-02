import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/register_screen.dart';
import 'screens/login/forgot_password_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/forgot-password': (context) => const ForgetPasswordPage(),
};
