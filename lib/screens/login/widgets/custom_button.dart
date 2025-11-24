import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // <-- nullable

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, // <-- allow null
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // <-- Flutter otomatis disable jika null
      child: Text(text),
    );
  }
}
