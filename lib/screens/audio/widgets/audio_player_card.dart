import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AudioPlayerCard extends StatelessWidget {
  final WebViewController controller;

  const AudioPlayerCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: 400,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
