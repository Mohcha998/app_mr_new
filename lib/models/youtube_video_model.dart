class YoutubeVideo {
  final String videoId;
  final String title;
  final String thumbnail;

  YoutubeVideo({
    required this.videoId,
    required this.title,
    required this.thumbnail,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      videoId: json["id"]["videoId"],
      title: json["snippet"]["title"],
      thumbnail: json["snippet"]["thumbnails"]["high"]["url"],
    );
  }
}
