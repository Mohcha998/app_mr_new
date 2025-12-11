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
              height: 56.25vw; /* 16:9 ratio */
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
      child: WebViewWidget(controller: _controller),
    );
  }
}
