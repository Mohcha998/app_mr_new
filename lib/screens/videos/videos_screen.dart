// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../services/youtube_service.dart';
import '../../models/youtube_playlist_model.dart';
import '../videos-detail/playlist_detail_page.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  bool loadingTop = true;
  bool loadingList = true;

  String? latestVideoId;
  String latestVideoTitle = "";

  List<YoutubePlaylist> playlists = [];

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  // =====================================================
  // FETCH SEMUA DATA (Playlists + Latest Video)
  // =====================================================
  Future<void> fetchAll() async {
    try {
      playlists = await YoutubeService.getPlaylists();

      if (playlists.isNotEmpty) {
        final firstPlaylistId = playlists[0].id;

        final items = await YoutubeService.getPlaylistItems(firstPlaylistId);

        if (items.isNotEmpty) {
          latestVideoId = items[0].videoId;
          latestVideoTitle = items[0].title;
        }
      }
    } catch (e) {
      print("Error fetchAll: $e");
    }

    setState(() {
      loadingTop = false;
      loadingList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Videos",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================
            // VIDEO TERBARU
            // ======================================
            Padding(
              padding: const EdgeInsets.all(16),
              child: loadingTop || latestVideoId == null
                  ? Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoWebViewPage(
                              videoId: latestVideoId!,
                              title: latestVideoTitle,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://img.youtube.com/vi/$latestVideoId/hqdefault.jpg",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Video Terbaru",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            latestVideoTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),

            // ======================================
            // TITLE PLAYLIST
            // ======================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFCC2A2A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Playlist",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // ======================================
            // LIST PLAYLIST
            // ======================================
            loadingList
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: playlists.length,
                    itemBuilder: (context, i) {
                      final item = playlists[i];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlaylistDetailPage(
                                playlistId: item.id,
                                title: item.title,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.thumbnail,
                                  width: 110,
                                  height: 65,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 110,
                                    height: 65,
                                    color: Colors.grey.shade300,
                                    child: Icon(Icons.play_arrow),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "${item.title}\n${item.itemCount} videos",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 18),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// VIDEO WEBVIEW PAGE
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

    // Inisialisasi WebViewController untuk Flutter 4.x
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
