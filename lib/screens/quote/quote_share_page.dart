import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class QuoteSharePage extends StatelessWidget {
  final String imagePath;
  final String quote;
  final Offset textPosition;
  final double textBoxWidth;
  final String font;
  final Color textColor; // <-- menerima warna dari editor

  const QuoteSharePage({
    super.key,
    required this.imagePath,
    required this.quote,
    required this.textPosition,
    required this.textBoxWidth,
    required this.font,
    required this.textColor, // <-- ditambahkan
  });

  TextStyle _getFontStyle(String font, Color color, double size) {
    switch (font) {
      case "Allura":
        return GoogleFonts.allura(color: color, fontSize: size);
      case "Dancing Script":
        return GoogleFonts.dancingScript(color: color, fontSize: size);
      case "Playfair Display":
        return GoogleFonts.playfairDisplay(color: color, fontSize: size);
      case "Lora":
        return GoogleFonts.lora(color: color, fontSize: size);
      case "Roboto Slab":
        return GoogleFonts.robotoSlab(color: color, fontSize: size);
      case "Great Vibes":
        return GoogleFonts.greatVibes(color: color, fontSize: size);
      case "Montserrat":
        return GoogleFonts.montserrat(color: color, fontSize: size);
      case "Pacifico":
        return GoogleFonts.pacifico(color: color, fontSize: size);
      case "Georgia":
        return TextStyle(fontFamily: "Georgia", color: color, fontSize: size);
      default:
        return TextStyle(fontFamily: "Helvetica", color: color, fontSize: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAsset = !imagePath.startsWith('/');

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Share Preview"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () async {
              final shouldExit = await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text(
                      "Leave This Page?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    content: const Text(
                      "If you leave this page now, your edited quote image will not be saved.\n"
                      "Are you sure you want to exit?",
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      // YES = exit
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Yes"),
                      ),

                      // NO = stay (pindah ke kanan sesuai permintaan)
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("No"),
                      ),
                    ],
                  );
                },
              );

              if (shouldExit == true) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: 3 / 4, // <-- FIXED RATIO 3:4
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    isAsset
                        ? Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),

                    // ================= TEXT + SIGNATURE =================
                    Positioned(
                      left: textPosition.dx,
                      top: textPosition.dy,
                      child: SizedBox(
                        width: textBoxWidth,
                        child: Column(
                          children: [
                            Text(
                              quote,
                              textAlign: TextAlign.center,
                              style: _getFontStyle(font, textColor, 22)
                                  .copyWith(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3,
                                        color: Colors.black.withOpacity(0.4),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              "assets/images/signature.png",
                              height: 32,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () async {
              try {
                if (imagePath.startsWith('/')) {
                  await Share.shareXFiles([XFile(imagePath)], text: quote);
                } else {
                  await Share.share(quote);
                }
              } catch (e) {
                debugPrint("Error sharing: $e");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text(
              "Share",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
