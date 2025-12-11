import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class QuotePreviewPage extends StatelessWidget {
  final String imageUrl;

  const QuotePreviewPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share(imageUrl); // share link gambar
            },
          ),
        ],
      ),

      body: Center(child: InteractiveViewer(child: Image.network(imageUrl))),
    );
  }
}
