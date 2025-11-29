import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../session/user_session.dart';
import '../home/home_screen.dart';
import './register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ================= BACKGROUND =================
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5C0A0C), Color(0xFF8A1012), Color(0xFFB41718)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ================= LOGO =================
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "assets/icon/merry.png",
                    height: 380,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= FORM =================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- EMAIL ----------
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ---------- PASSWORD ----------
                      TextField(
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ================= LOGIN BUTTON =================
                      authProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () async {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text
                                      .trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Email dan Password wajib diisi",
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  await authProvider.login(
                                    email: email,
                                    password: password,
                                  );

                                  // ================= LOGIN BERHASIL =================
                                  if (authProvider.user != null && mounted) {
                                    final user = authProvider.user!;

                                    /// ✅ SIMPAN KE SESSION (WAJIB)
                                    UserSession.name = user.name;
                                    UserSession.email = user.email;
                                    UserSession.phone = user.mobile;

                                    debugPrint("✅ LOGIN SUCCESS");
                                    debugPrint("Name  : ${UserSession.name}");
                                    debugPrint("Email : ${UserSession.email}");
                                    debugPrint("Phone : ${UserSession.phone}");

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomeScreen(user: user),
                                      ),
                                    );
                                  }
                                  // ================= LOGIN GAGAL =================
                                  else if (authProvider.error != null &&
                                      mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(authProvider.error!),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                      const SizedBox(height: 24),

                      // ================= REGISTER =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFFFFD93D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
