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

  const QuoteSharePage({
    super.key,
    required this.imagePath,
    required this.quote,
    required this.textPosition,
    required this.textBoxWidth,
    required this.font,
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
          TextButton(
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
                    ),
                    content: const Text(
                      "If you leave this page now, your edited quote image will not be saved. "
                      "Are you sure you want to exit?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Stay"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Exit"),
                      ),
                    ],
                  );
                },
              );

              // Jika user memilih keluar
              if (shouldExit == true) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: const Text("Done", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AREA GAMBAR FINAL TANPA BACKGROUND HITAM
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // IMAGE
                  isAsset
                      ? Image.asset(
                          imagePath,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.6,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.6,
                          fit: BoxFit.cover,
                        ),

                  // TEXT + SIGNATURE (TANPA BACKGROUND)
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
                            style: _getFontStyle(font, Colors.white, 22)
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

                          // SIGNATURE
                          Image.asset(
                            "assets/images/signature.png",
                            height: 32,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // SHARE BUTTON
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
