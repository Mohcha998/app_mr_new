// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // ===========================================
  // CUSTOM URUTAN PLAYLIST
  // ===========================================
  final List<String> priorityOrder = [
    "POPULAR VIDEOS",
    "ABOUT MERRY RIANA",
    "THE MENTOR",
    "FRIENDS OF MERRY RIANA",
    "SPOKEN WORD",
    "MOTIVASI MERRY",
    "MERRY STORY",
    "#JADIARTINYA",
    "VLOG MISS MERRY",
    "MERRY RIANA GROUP",
  ];

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  // ===========================================
  // FETCH SEMUA DATA
  // ===========================================
  Future<void> fetchAll() async {
    try {
      // Fetch latest video
      final latestVideos = await YoutubeService.getLatestVideos();

      if (latestVideos.isNotEmpty) {
        final latest = latestVideos.last;

        latestVideoId = latest.videoId;
        latestVideoTitle = latest.title;
      }

      // Fetch playlists
      playlists = await YoutubeService.getPlaylists();

      // Sorting playlist custom
      playlists.sort((a, b) {
        int indexA = priorityOrder.indexOf(a.title.toUpperCase());
        int indexB = priorityOrder.indexOf(b.title.toUpperCase());

        if (indexA == -1) indexA = 999;
        if (indexB == -1) indexB = 999;

        return indexA.compareTo(indexB);
      });
    } catch (e) {
      print("Error fetchAll: $e");
    }

    setState(() {
      loadingTop = false;
      loadingList = false;
    });
  }

  // ===========================================
  // OPEN YOUTUBE APP / BROWSER
  // ===========================================
  Future<void> openYoutube(String videoId) async {
    final url = Uri.parse("https://www.youtube.com/watch?v=$videoId");

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // <-- langsung buka YouTube
      );
    } else {
      print("Tidak bisa membuka YouTube");
    }
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
                      onTap: () => openYoutube(latestVideoId!),
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
