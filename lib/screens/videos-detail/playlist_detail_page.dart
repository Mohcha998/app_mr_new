// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/youtube_playlist_item_model.dart';
import '../../services/youtube_service.dart';

class PlaylistDetailPage extends StatefulWidget {
  final String playlistId;
  final String title;

  const PlaylistDetailPage({
    super.key,
    required this.playlistId,
    required this.title,
  });

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  bool loading = true;
  List<YoutubePlaylistItem> videos = [];

  @override
  void initState() {
    super.initState();
    fetchPlaylistItems();
  }

  Future<void> fetchPlaylistItems() async {
    try {
      final items = await YoutubeService.getPlaylistItems(widget.playlistId);

      // Filter: hilangkan video private atau tidak valid
      final filtered = items.where((item) {
        return item.title.isNotEmpty && item.thumbnail.isNotEmpty;
      }).toList();

      setState(() {
        videos = filtered;
        loading = false;
      });
    } catch (e) {
      print("Error fetching playlist items: $e");
      setState(() => loading = false);
    }
  }

  void openVideo(YoutubePlaylistItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            VideoWebViewPage(videoId: item.videoId, title: item.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: EdgeInsets.all(12),
              itemCount: videos.length,
              separatorBuilder: (_, __) => SizedBox(height: 12),
              itemBuilder: (context, i) {
                final item = videos[i];
                return InkWell(
                  onTap: () => openVideo(item),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          child: Image.network(
                            item.thumbnail,
                            width: 120,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(Icons.play_arrow, color: Colors.red),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// =====================================================
// Video WebView Page
// =====================================================
class VideoWebViewPage extends StatefulWidget {
  final String videoId;
  final String title;

  const VideoWebViewPage({
    super.key,
    required this.videoId,
    required this.title,
  });

  @override
  State<VideoWebViewPage> createState() => _VideoWebViewPageState();
}

class _VideoWebViewPageState extends State<VideoWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://www.youtube.com/embed/${widget.videoId}?autoplay=1"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.red),
      body: WebViewWidget(controller: _controller),
    );
  }
}
