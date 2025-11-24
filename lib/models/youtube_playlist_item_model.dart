import '../helpers/youtube_thumbnail.dart';

class YoutubePlaylistItem {
  final String videoId;
  final String title;
  final String thumbnail;
  final String publishedAt;

  YoutubePlaylistItem({
    required this.videoId,
    required this.title,
    required this.thumbnail,
    required this.publishedAt,
  });

  factory YoutubePlaylistItem.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'] as Map<String, dynamic>? ?? {};
    final resource = snippet['resourceId'] as Map<String, dynamic>? ?? {};
    final contentDetails =
        json['contentDetails'] as Map<String, dynamic>? ?? {};

    String vid = '';
    if (contentDetails['videoId'] != null) {
      vid = contentDetails['videoId'].toString();
    } else if (resource['videoId'] != null) {
      vid = resource['videoId'].toString();
    }

    final thumbs = snippet['thumbnails'] as Map<String, dynamic>? ?? {};

    return YoutubePlaylistItem(
      videoId: vid,
      title: snippet['title']?.toString() ?? '',
      thumbnail: YoutubeThumbnail.extract(thumbs),
      publishedAt: snippet['publishedAt']?.toString() ?? '',
    );
  }
}
