import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

// Screens
import 'screens/login/login_screen.dart';
import 'screens/quote/edit_image_screen.dart';
import 'screens/quote/quote_editor_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      theme: ThemeData(primarySwatch: Colors.blue),

      // Halaman pertama saat aplikasi dibuka
      home: const LoginScreen(),

      // ✅ Daftar route aplikasi
      routes: {
        '/login': (context) => const LoginScreen(),
        '/edit_image_screen': (context) => const EditImagePage(),
        '/quote_editor_page': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return QuoteEditorPage(
            imagePath: args['imagePath'],
            quote: args['quote'],
          );
        },
      },
    );
  }
}
