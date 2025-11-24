import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quote_share_page.dart';

class QuoteEditorPage extends StatefulWidget {
  final String imagePath;
  final String quote;

  const QuoteEditorPage({
    super.key,
    required this.imagePath,
    required this.quote,
  });

  @override
  State<QuoteEditorPage> createState() => _QuoteEditorPageState();
}

class _QuoteEditorPageState extends State<QuoteEditorPage> {
  Offset textPosition = const Offset(50, 200);
  double textBoxWidth = 280;
  String selectedFont = "Helvetica";
  Color textColor = Colors.white;

  final List<String> fonts = [
    "Helvetica",
    "Allura",
    "Georgia",
    "Dancing Script",
    "Playfair Display",
    "Lora",
    "Roboto Slab",
    "Great Vibes",
    "Montserrat",
    "Pacifico",
  ];

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
    final bool isAsset = !widget.imagePath.startsWith('/');

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Image"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuoteSharePage(
                    imagePath: widget.imagePath,
                    quote: widget.quote,
                    font: selectedFont,
                    textPosition: textPosition,
                    textBoxWidth: textBoxWidth,
                  ),
                ),
              );
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),

      body: Column(
        children: [
          // ====================== IMAGE AREA ==========================
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: isAsset
                        ? Image.asset(
                            widget.imagePath,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                          )
                        : Image.file(
                            File(widget.imagePath),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.6,
                          ),
                  ),

                  // ====================== TEXT + SIGNATURE ======================
                  Positioned(
                    left: textPosition.dx,
                    top: textPosition.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          textPosition += details.delta;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: textBoxWidth,
                            padding: const EdgeInsets.all(4),
                            color: Colors.black12.withOpacity(0.08),
                            child: Text(
                              widget.quote,
                              textAlign: TextAlign.center,
                              style: _getFontStyle(selectedFont, textColor, 22)
                                  .copyWith(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3,
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // SIGNATURE image
                          Image.asset(
                            "assets/images/signature.png",
                            height: 32,
                            fit: BoxFit.contain,
                            color: textColor, // Signature mengikuti warna
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ====================== RESIZE HANDLE ==========================
                  Positioned(
                    left: textPosition.dx + textBoxWidth + 8,
                    top: textPosition.dy + 40,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          textBoxWidth += details.delta.dx;
                          if (textBoxWidth < 150) textBoxWidth = 150;
                          if (textBoxWidth > 350) textBoxWidth = 350;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 60,
                        color: Colors.black26,
                        child: const Icon(Icons.drag_indicator, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ====================== FONT SELECTOR & COLOR ========================
          Container(
            height: 260,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Font label + switch color
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose Font",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text("Text Color"),
                        const SizedBox(width: 8),
                        Switch(
                          value: textColor == Colors.white,
                          onChanged: (v) {
                            setState(() {
                              textColor = v ? Colors.white : Colors.black;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView.separated(
                    itemCount: fonts.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.black12, height: 1),
                    itemBuilder: (_, index) {
                      final font = fonts[index];

                      return ListTile(
                        title: Text(
                          font,
                          style: _getFontStyle(font, Colors.black, 20),
                        ),
                        trailing: selectedFont == font
                            ? const Icon(Icons.check, color: Colors.red)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedFont = font;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
