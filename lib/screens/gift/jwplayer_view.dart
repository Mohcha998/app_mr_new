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

    final html =
        """
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <style>
          html, body {
            margin: 0;
            padding: 0;
            background: black;
            width: 100%;
            height: 100%;
            overflow: hidden;
          }
          #wrapper {
            width: 100%;
            height: calc(100% - 80px); /* ruang untuk bottom bar */
            background: black;
          }
          iframe {
            border: none;
            width: 100%;
            height: 100%;
          }
        </style>
      </head>
      <body>
        <div id="wrapper">
          <iframe
            src="https://cdn.jwplayer.com/players/${widget.videoId}.html?isIFRAME=true&autostart=false"
            allowfullscreen
          ></iframe>
        </div>
      </body>
      </html>
    """;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(255, 255, 255, 255))
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
