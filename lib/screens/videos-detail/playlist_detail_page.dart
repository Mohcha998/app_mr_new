// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  // =====================================================
  // OPEN YOUTUBE APP OR BROWSER
  // =====================================================
  Future<void> openYoutube(String videoId) async {
    final url = Uri.parse("https://www.youtube.com/watch?v=$videoId");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // fallback
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    }
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
                  onTap: () => openYoutube(item.videoId),
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
                        Icon(Icons.open_in_new, color: Colors.red),
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
