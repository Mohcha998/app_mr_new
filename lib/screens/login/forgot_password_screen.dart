import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool emailChecked = false;
  bool isLoading = false;

  final ApiService api = ApiService();

  Future<void> checkEmail() async {
    setState(() => isLoading = true);

    final email = emailController.text.trim();

    try {
      final user = await api.checkByEmail(email);

      if (user != null) {
        setState(() => emailChecked = true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email ditemukan! Silakan buat password baru."),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() => emailChecked = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email tidak ditemukan."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => emailChecked = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> updatePassword() async {
    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final success = await api.updatePassword(email, password);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password berhasil diperbarui!"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context); // kembali ke halaman login
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // TITLE
            const Text(
              "Reset Your Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              !emailChecked
                  ? "Masukkan email kamu untuk mengecek apakah terdaftar."
                  : "Email valid! Sekarang masukkan password baru kamu.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 30),

            // EMAIL INPUT
            TextField(
              controller: emailController,
              enabled: !emailChecked,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CHECK EMAIL BUTTON
            if (!emailChecked)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : checkEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Check Email",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),

            // NEW PASSWORD FIELD ONLY AFTER EMAIL VALID
            if (emailChecked) ...[
              const SizedBox(height: 25),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: const Icon(Icons.lock_reset),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // UPDATE PASSWORD BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : updatePassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Update Password",
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
