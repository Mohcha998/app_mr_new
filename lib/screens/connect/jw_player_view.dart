import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JWPlayerView extends StatefulWidget {
  final String videoId;

  const JWPlayerView({super.key, required this.videoId});

  @override
  State<JWPlayerView> createState() => _JWPlayerViewState();
}

class _JWPlayerViewState extends State<JWPlayerView> {
  late final WebViewController _controller;
  bool showPlayer = false; // <<< UNTUK MENGATUR THUMBNAIL

  @override
  void initState() {
    super.initState();

    final iframe =
        """
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body, html {
              margin: 0;
              padding: 0;
              background: black;
              overflow: hidden;
            }
            iframe {
              border: none;
              width: 100vw;
              height: 56.25vw; /* rasio 16:9 */
              max-height: 100vh;
            }
          </style>
        </head>
        <body>
          <iframe 
            src="https://cdn.jwplayer.com/players/${widget.videoId}.html?isIFRAME=true"
            allowfullscreen
            scrolling="no"
          ></iframe>
        </body>
      </html>
    """;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(iframe);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,

      child: Stack(
        children: [
          // ============================
          // 1) WEBVIEW (VIDEO PLAYER)
          // ============================
          if (showPlayer) WebViewWidget(controller: _controller),

          // ============================
          // 2) THUMBNAIL (DEFAULT TAMPIL)
          // ============================
          if (!showPlayer)
            GestureDetector(
              onTap: () {
                setState(() => showPlayer = true);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // GAMBAR THUMBNAIL
                  Image.asset("assets/images/thmbnl.webp", fit: BoxFit.cover),

                  // GRADIENT / OVERLAY (opsional)
                  Container(color: Colors.black.withOpacity(0.25)),

                  // TOMBOL PLAY
                  Center(
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        size: 42,
                        color: Colors.black,
                      ),
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
