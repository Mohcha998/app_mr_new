import '../helpers/youtube_thumbnail.dart';

class YoutubePlaylist {
  final String id;
  final String title;
  final String thumbnail;
  final int itemCount;

  YoutubePlaylist({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.itemCount,
  });

  factory YoutubePlaylist.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'] as Map<String, dynamic>? ?? {};
    final contentDetails =
        json['contentDetails'] as Map<String, dynamic>? ?? {};
    final thumbs = snippet['thumbnails'] as Map<String, dynamic>? ?? {};

    return YoutubePlaylist(
      id: json['id']?.toString() ?? '',
      title: snippet['title']?.toString() ?? '',
      thumbnail: YoutubeThumbnail.extract(thumbs),
      itemCount:
          int.tryParse(contentDetails['itemCount']?.toString() ?? '0') ?? 0,
    );
  }
}
