import 'package:flutter/material.dart';

class PodcastButton extends StatelessWidget {
  const PodcastButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width * 0.9, // ⬅ LEBIH LEBAR
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "Podcast",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
