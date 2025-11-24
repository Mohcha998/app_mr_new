import 'package:flutter/material.dart';
import '../../services/register_service.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  final registerService = RegisterService();
  bool isLoading = false;

  void handleRegister() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final mobile = mobileController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || mobile.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi!")));
      return;
    }

    setState(() => isLoading = true);

    final result = await registerService.register(
      name: name,
      email: email,
      mobile: mobile,
      password: password,
    );

    setState(() => isLoading = false);

    if (result["success"] == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Register berhasil!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Register gagal")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(label: "Nama Lengkap", controller: nameController),
            const SizedBox(height: 12),
            CustomTextField(label: "Email", controller: emailController),
            const SizedBox(height: 12),
            CustomTextField(label: "Nomor HP", controller: mobileController),
            const SizedBox(height: 12),
            CustomTextField(
              label: "Password",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 18),

            CustomButton(
              text: isLoading ? "Loading..." : "Daftar",
              onPressed: isLoading ? null : handleRegister,
            ),
          ],
        ),
      ),
    );
  }
}
