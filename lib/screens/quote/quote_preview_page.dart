import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

import '../../models/quote_model.dart';
import '../quote-gallery/quote_gallery_screen.dart';

class QuotePreviewPage extends StatefulWidget {
  final Quote quote;

  const QuotePreviewPage({super.key, required this.quote});

  @override
  State<QuotePreviewPage> createState() => _QuotePreviewPageState();
}

class _QuotePreviewPageState extends State<QuotePreviewPage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  /// ===============================
  /// SHARE QUOTE AS IMAGE
  /// ===============================
  Future<void> _shareQuoteImage() async {
    try {
      final Uint8List? image = await _screenshotController.capture(
        pixelRatio: 2.0,
      );

      if (image == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal mengambil gambar')));
        return;
      }

      final tempDir = Directory.systemTemp;
      final file = await File('${tempDir.path}/quote.png').writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(file.path)],
        text:
            '"${widget.quote.text}"\n— ${widget.quote.author ?? "Merry Riana"}',
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saat share: $e')));
    }
  }

  /// ===============================
  /// POPUP MENU HANDLER
  /// ===============================
  void _onMenuSelected(String value) {
    switch (value) {
      case 'edit':
        Navigator.pushNamed(
          context,
          '/edit_image_screen',
          arguments: widget.quote,
        );
        break;

      case 'gallery':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QuotesGalleryPage()),
        );
        break;

      case 'share':
        _shareQuoteImage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = width * 4 / 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ===============================
          /// CLOSE BUTTON
          /// ===============================
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, size: 28, color: Colors.black),
            ),
          ),

          /// ===============================
          /// MAIN QUOTE PREVIEW
          /// ===============================
          Center(
            child: Screenshot(
              controller: _screenshotController,
              child: Container(
                width: width * 0.85,
                height: height * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      /// BACKGROUND
                      Image.asset(
                        "assets/images/9.jpg",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      /// DARK OVERLAY
                      Container(color: Colors.black.withOpacity(0.45)),

                      /// QUOTE TEXT
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.quote.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Image.asset(
                                  'assets/images/signature.png',
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// ===============================
                      /// POPUP MENU
                      /// ===============================
                      Positioned(
                        bottom: 14,
                        right: 12,
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 26,
                          ),
                          onSelected: _onMenuSelected,
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 18),
                                  SizedBox(width: 8),
                                  Text("Edit Image"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "gallery",
                              child: Row(
                                children: [
                                  Icon(Icons.collections, size: 18),
                                  SizedBox(width: 8),
                                  Text("Quotes Gallery"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "share",
                              child: Row(
                                children: [
                                  Icon(Icons.share, size: 18),
                                  SizedBox(width: 8),
                                  Text("Share"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
