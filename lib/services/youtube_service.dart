import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../models/youtube_video_model.dart';
import '../models/youtube_playlist_item_model.dart';
import '../models/youtube_playlist_model.dart';

class YoutubeService {
  // =========================
  // Get Latest Videos
  // =========================
  static Future<List<YoutubeVideo>> getLatestVideos() async {
    final url = "${ApiConstants.baseUrl}/youtube/latest";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List items = (jsonBody["data"]?["items"] ?? []) as List;

      return items.map((e) => YoutubeVideo.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load YouTube videos: ${response.statusCode}");
    }
  }

  // =========================
  // Get Playlists
  // =========================
  static Future<List<YoutubePlaylist>> getPlaylists() async {
    final url = "${ApiConstants.baseUrl}/youtube/playlists";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List items = (jsonBody["data"]?["items"] ?? []) as List;

      return items.map((e) => YoutubePlaylist.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load playlists: ${response.statusCode}");
    }
  }

  // =========================
  // Get Playlist Items
  // =========================
  static Future<List<YoutubePlaylistItem>> getPlaylistItems(
    String playlistId,
  ) async {
    if (playlistId.isEmpty) return [];

    final url =
        "${ApiConstants.baseUrl}/youtube/playlist-items?playlistId=$playlistId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List items = (jsonBody["data"]?["items"] ?? []) as List;

      return items.map((e) => YoutubePlaylistItem.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load playlist items: ${response.statusCode}");
    }
  }
}
