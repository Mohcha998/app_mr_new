import 'package:flutter/material.dart';

class AudioBanner extends StatelessWidget {
  const AudioBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.asset(
        "assets/images/merry_header_audio.png",
        width: double.infinity,
        height: 260,
        fit: BoxFit.cover,
      ),
    );
  }
}
