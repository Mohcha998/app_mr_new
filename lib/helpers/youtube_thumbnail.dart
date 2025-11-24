class YoutubeThumbnail {
  static String extract(Map<String, dynamic> thumbs) {
    if (thumbs.isEmpty) return '';

    if (thumbs.containsKey('maxres')) {
      return thumbs['maxres']['url'] ?? _firstAvailable(thumbs);
    }
    if (thumbs.containsKey('standard')) {
      return thumbs['standard']['url'] ?? _firstAvailable(thumbs);
    }
    if (thumbs.containsKey('high')) {
      return thumbs['high']['url'] ?? _firstAvailable(thumbs);
    }
    if (thumbs.containsKey('medium')) {
      return thumbs['medium']['url'] ?? _firstAvailable(thumbs);
    }
    if (thumbs.containsKey('default')) {
      return thumbs['default']['url'] ?? '';
    }

    return _firstAvailable(thumbs);
  }

  static String _firstAvailable(Map<String, dynamic> thumbs) {
    for (final v in thumbs.values) {
      if (v is Map && v['url'] != null) return v['url'].toString();
    }
    return '';
  }
}
