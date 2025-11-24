import 'package:flutter/material.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(label: "Email", controller: emailController),
            const SizedBox(height: 16),
            CustomButton(
              text: "Kirim Link Reset",
              onPressed: () {
                // TODO: Implement forgot password logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
